import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kenryo_tankyu/core/theme/theme.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/welcome_page.dart';
import 'package:kenryo_tankyu/presentation/widget/transition_notice_card.dart';

void main() {
  for (final scale in [1.0, 2.0]) {
    testWidgets('小さい画面・文字倍率$scaleでも案内を閉じてログインできる', (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          theme: ThemeData(
              useMaterial3: true, colorScheme: MaterialTheme.lightScheme()),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(scale)),
            child: child!,
          ),
          home: const WelcomePage(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      final details = find.text('移行とサービス終了について');
      await tester.ensureVisible(details);
      await tester.tap(details);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('閉じる'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.byType(TransitionNoticeCard), findsOneWidget);

      await tester.ensureVisible(find.text('縣陵アカウントでサインイン'));
      expect(find.text('縣陵アカウントでサインイン').hitTestable(), findsOneWidget);
      await tester.ensureVisible(find.text('ログイン（メール）'));
      expect(find.text('ログイン（メール）').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
