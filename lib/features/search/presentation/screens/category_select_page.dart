import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/category.dart';

class CategorySelectPage extends StatelessWidget {
  const CategorySelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カテゴリから選ぶ'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      body: const CategoryList(),
    );
  }
}
