import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestSelectPage extends StatelessWidget {
  const TestSelectPage({super.key});
  static final items = ['みつきくん用', 'こじさん用', 'あおい用'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              if (index == 0) {
                context.go('/testSelect/mitsuki');
              } else if (index == 1) {
                context.go('/testSelect/coji');
              } else if (index == 2) {
                context.go('/testSelect/aoi');
              }
            },
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
