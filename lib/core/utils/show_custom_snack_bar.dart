import 'package:flutter/material.dart';

showCustomSnackBar(BuildContext context, String msg,
    {bool taskSuccess = true}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      backgroundColor: taskSuccess == true
          ? Colors.green.withOpacity(0.9)
          : Colors.red.withOpacity(0.9),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
