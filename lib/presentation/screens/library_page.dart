import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/history_list.dart';

///TODO あまり納得いってないよこのタブ
///あと、riverpod使わずにstateful使っちゃってるのちょっと罪悪感あるし！
///ゆーてstateprovider１つ使うだけでよさそうなんだよな。

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25.0)),
            child: TabBar(
              indicatorWeight: 3.0,
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Theme.of(context).primaryColor,
              ),
              labelColor: Colors.white,
              tabs: [
                _tab(label: '閲覧履歴', icon: const Icon(Icons.history)),
                _tab(label: 'お気に入り', icon: const Icon(Icons.favorite)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          LibraryList(onlyFavorite: false),
          LibraryList(onlyFavorite: true),
        ], //TODO,, tabcontrollerがindexを管理してくれているから、順番に作っちゃうだけでおけ
      ),
    );
  }

  Widget _tab({required String label, required Icon icon}) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8.0),
          Text(label),
        ],
      ),
    );
  }
}
