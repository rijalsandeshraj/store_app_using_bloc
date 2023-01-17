import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class AppBarIconWidget extends StatelessWidget {
  const AppBarIconWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        alignment: Alignment.center,
        width: 35,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.white,
        ),
        child: child,
      ),
    );
  }
}
