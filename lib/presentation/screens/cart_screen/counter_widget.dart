import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
    this.value, {
    Key? key,
    this.onDecrementPressed,
    this.onIncrementPressed,
  }) : super(key: key);

  final String value;
  final Function()? onDecrementPressed;
  final void Function()? onIncrementPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 27,
          width: 27,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.primaryPink.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 27,
            icon: const Icon(
              Icons.remove,
              color: AppColor.white,
            ),
            onPressed: onDecrementPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: productPrice2TextStyle,
          ),
        ),
        Container(
          height: 27,
          width: 27,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.primaryPink.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 27,
            icon: const Icon(
              Icons.add_rounded,
              color: AppColor.white,
            ),
            onPressed: onIncrementPressed,
          ),
        ),
      ],
    );
  }
}
