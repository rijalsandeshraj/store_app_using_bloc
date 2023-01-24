import 'package:flutter/material.dart';
import 'package:store_app_using_bloc/core/utils/show_custom_snack_bar.dart';
import 'package:store_app_using_bloc/presentation/animations/animated_switcher_wrapper.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class TotalAmountWidget extends StatelessWidget {
  const TotalAmountWidget({
    Key? key,
    required this.totalPrice,
    required this.containerWidth,
  }) : super(key: key);

  final double totalPrice;
  final double containerWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: AppColor.purple.withOpacity(0.7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: containerWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal',
                        style: cartScreenCalculationTextStyle),
                    Text('\$ ${(totalPrice - 5).toStringAsFixed(2)}',
                        style: cartScreenPriceTextStyle),
                  ],
                ),
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Delivery Charges',
                        style: cartScreenCalculationTextStyle),
                    Text('\$ ${5.00}', style: cartScreenPriceTextStyle),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 55,
              child: VerticalDivider(
                thickness: 2,
              )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: containerWidth - 41,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: cartScreenCalculationTextStyle),
                    AnimatedSwitcherWrapper(
                      child: Text(
                        totalPrice == 5.0
                            ? '\$ 0.0'
                            : '\$ ${totalPrice.toStringAsFixed(2)}',
                        key: ValueKey(totalPrice),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 9),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    showCustomSnackBar(
                        context, 'Your will receive your products soon!');
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryPink)),
                  child: const Text('Checkout'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
