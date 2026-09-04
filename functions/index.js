"use strict";

const {initializeApp} = require("firebase-admin/app");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {google} = require("googleapis");

initializeApp();

const REGION = "asia-northeast1";
const SHEET_REPORT_SERVICE_ACCOUNT =
  "sheet-report-function@tankyu-app.iam.gserviceaccount.com";
const SPREADSHEET_ID = "1g9kG-6wlBxWQ-kq4tyFtWjRJvJbWqLNLoJ_C67WYmaw";
const MAX_TEXT_LENGTH = 500;
const MAX_PDF_TYPE_COUNT = 10;

const reportDefinitions = {
  suggestCategory: {
    range: "suggest_other_category!A1",
    buildRow: ({timestamp, email, documentId, data}) => [
      timestamp,
      email,
      String(documentId),
      readText(data, "radioLabel", 20),
      readText(data, "newCategory", 50),
      readText(data, "newSubCategory", 50),
    ],
  },
  suggestWorksInfo: {
    range: "suggest_works_info!A1",
    buildRow: ({timestamp, email, documentId, data}) => [
      timestamp,
      email,
      String(documentId),
      readText(data, "author", 100),
      readText(data, "title", 200),
      readText(data, "course", 50),
      readText(data, "enterYear", 20),
    ],
  },
  cannotViewPdf: {
    range: "cannot_view_pdf!A1",
    buildRow: ({timestamp, email, documentId, data}) => [
      timestamp,
      email,
      String(documentId),
      readPdfTypes(data),
      readText(data, "freeDescription", MAX_TEXT_LENGTH),
    ],
  },
  otherReason: {
    range: "other_reason!A1",
    buildRow: ({timestamp, email, documentId, data}) => [
      timestamp,
      email,
      String(documentId),
      readText(data, "freeText", MAX_TEXT_LENGTH),
    ],
  },
};

exports.submitSheetReport = onCall(
    {
      region: REGION,
      serviceAccount: SHEET_REPORT_SERVICE_ACCOUNT,
    },
    async (request) => {
      if (!request.auth) {
        throw new HttpsError("unauthenticated", "ログインが必要です。");
      }

      const email = request.auth.token.email;
      if (typeof email !== "string" || !email.endsWith("@kenryo.ed.jp")) {
        throw new HttpsError("permission-denied", "許可されたアカウントではありません。");
      }

      const data = request.data;
      if (!isPlainObject(data)) {
        throw new HttpsError("invalid-argument", "送信内容が不正です。");
      }

      const definition = reportDefinitions[data.type];
      if (!definition) {
        throw new HttpsError("invalid-argument", "報告種別が不正です。");
      }

      const documentId = readDocumentId(data);
      const timestamp = jstTimestamp();
      const values = definition.buildRow({timestamp, email, documentId, data});

      try {
        const sheets = google.sheets({
          version: "v4",
          auth: await google.auth.getClient({
            scopes: ["https://www.googleapis.com/auth/spreadsheets"],
          }),
        });

        await sheets.spreadsheets.values.append({
          spreadsheetId: SPREADSHEET_ID,
          range: definition.range,
          valueInputOption: "RAW",
          requestBody: {
            values: [values],
          },
        });
      } catch (error) {
        console.error("Failed to append sheet report", error);
        throw new HttpsError("internal", "報告の保存に失敗しました。");
      }

      return {ok: true};
    },
);

function isPlainObject(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

function readDocumentId(data) {
  const value = data.documentId;
  if (!Number.isInteger(value) || value <= 0) {
    throw new HttpsError("invalid-argument", "documentIdが不正です。");
  }
  return value;
}

function readText(data, field, maxLength) {
  const value = data[field];
  if (typeof value !== "string") {
    throw new HttpsError("invalid-argument", `${field}が不正です。`);
  }

  const trimmed = value.trim();
  if (trimmed.length > maxLength) {
    throw new HttpsError("invalid-argument", `${field}が長すぎます。`);
  }
  return trimmed;
}

function readPdfTypes(data) {
  const values = data.pdfTypes;
  if (!Array.isArray(values) || values.length > MAX_PDF_TYPE_COUNT) {
    throw new HttpsError("invalid-argument", "pdfTypesが不正です。");
  }

  return values.map((value) => {
    if (typeof value !== "string") {
      throw new HttpsError("invalid-argument", "pdfTypesが不正です。");
    }
    const trimmed = value.trim();
    if (trimmed.length > 50) {
      throw new HttpsError("invalid-argument", "pdfTypesが長すぎます。");
    }
    return trimmed;
  }).join(", ");
}

function jstTimestamp() {
  const formatter = new Intl.DateTimeFormat("ja-JP", {
    timeZone: "Asia/Tokyo",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
    hour12: false,
  });

  const parts = Object.fromEntries(
      formatter.formatToParts(new Date()).map((part) => [part.type, part.value]),
  );
  return `${parts.year}-${parts.month}-${parts.day} ` +
    `${parts.hour}:${parts.minute}:${parts.second}`;
}
