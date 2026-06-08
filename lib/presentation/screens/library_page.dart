import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/history_list.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.history), text: '閲覧履歴'),
              Tab(icon: Icon(Icons.favorite), text: 'お気に入り'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LibraryList(onlyFavorite: false),
            LibraryList(onlyFavorite: true),
          ],
        ),
      ),
    );
  }
}
