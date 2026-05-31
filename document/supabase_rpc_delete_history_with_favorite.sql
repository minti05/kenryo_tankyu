-- #160 対応: browsing_history と favorites を原子的に削除する RPC 関数
-- Supabase の SQL Editor で実行してください。
--
-- 用途: 閲覧履歴の個別削除時に、そのアイテムがお気に入りに登録されている場合も
--       favorites テーブルから同時に削除するトランザクションを提供します。

CREATE OR REPLACE FUNCTION delete_history_with_favorite(
  p_user_id     TEXT,
  p_document_id INTEGER
)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM browsing_history
    WHERE user_id = p_user_id AND document_id = p_document_id;

  DELETE FROM favorites
    WHERE user_id = p_user_id AND document_id = p_document_id;
END;
$$;
