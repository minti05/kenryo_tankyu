import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/widgets/favorite_button.dart';

class WorkTitle extends StatelessWidget {
  final Searched searched;
  const WorkTitle({super.key, required this.searched});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              searched.title,
              softWrap: true,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 4),
          FavoriteButton(searched: searched, isLarge: true),
        ],
      ),
    );
  }
}
