import 'package:flutter/material.dart';

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
                    const Text('Subtotal', style: normalTextStyle2),
                    Text('\$ ${totalPrice - 5}', style: normalTextStyle2),
                  ],
                ),
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Delivery Charges', style: normalTextStyle2),
                    Text('\$ ${5.00}', style: normalTextStyle2),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: normalTextStyle2),
                  Text(
                    totalPrice == 5.0 ? '\$ 0.0' : '\$ $totalPrice',
                    style: normalTextStyle2,
                  )
                ],
              ),
              const SizedBox(height: 9),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
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
