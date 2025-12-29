import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';

//現在のフッターの状態を管理するproider
final footerProvider = StateProvider<int>((ref) => 0);

class Footer extends ConsumerStatefulWidget {
  final Widget child;
  const Footer({super.key, required this.child});

  @override
  ConsumerState<Footer> createState() => _FooterState();
}

class _FooterState extends ConsumerState<Footer> {
  @override
  void initState() {
    super.initState();
    ref.read(firebaseMessagingProvider).getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = ref.watch(footerProvider);
    final notifier = ref.read(footerProvider.notifier);
    return Scaffold(
      appBar: const InitialHeader(),
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'ホーム'),
          NavigationDestination(icon: Icon(Icons.explore), label: '探索'),
          NavigationDestination(icon: Icon(Icons.bookmarks), label: 'ライブラリ'),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              notifier.state = 0;
              context.push('/home');
              break;
            case 1:
              notifier.state = 1;
              context.push('/explore');
              break;
            case 2:
              notifier.state = 2;
              context.push('/library');
              break;
            default:
              notifier.state = 0;
              context.push('/home');
          }
          setState(() {});
        },
      ),
    );
  }
}
