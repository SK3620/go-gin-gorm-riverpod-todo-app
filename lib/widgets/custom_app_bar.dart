import 'package:flutter/material.dart';

import '../config/routes/routes_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Widget? leading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.blue,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      actions: actions,
      leading: leading
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);  // AppBarの高さ
}
