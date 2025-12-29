import 'package:flutter/material.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double percent;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const AuthAppBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(appIcon, width: 40),
      bottom: PreferredSize(
        child: LinearProgressIndicator(value: percent),
        preferredSize: Size.fromHeight(3.0),
      ),
    );
  }
}
