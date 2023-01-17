import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.backgroundColor,
    this.actions,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: leading,
      title: title,
      actions: actions,
    );
  }
}
