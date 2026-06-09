import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class WorkTitle extends StatelessWidget {
  final Searched searched;
  final bool isDetailsExpanded;
  final VoidCallback onToggleDetails;

  const WorkTitle({
    super.key,
    required this.searched,
    required this.isDetailsExpanded,
    required this.onToggleDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              searched.title,
              softWrap: true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: onToggleDetails,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Icon(
                isDetailsExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 20,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
