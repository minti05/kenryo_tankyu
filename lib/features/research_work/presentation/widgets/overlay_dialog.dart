import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/change_info_from_user.dart';

class OverlayDialog extends ModalRoute<void> {
  final Searched searched;
  OverlayDialog(this.searched);
  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => true;
  @override
  Color get barrierColor => Colors.black.withValues(alpha: 0.2);
  @override
  String get barrierLabel => 'Custom Dialog';
  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: _buildDialogContent(context),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 0),
              const Text(
                '情報の変更を提案',
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          //TODO 一旦検証
          ChangeInfoFromUser(searched),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
