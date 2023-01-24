import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/all_products/all_products_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/product.dart';
import 'counter_widget.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    Key? key,
    required this.cartProduct,
    required this.deviceWidth,
  }) : super(key: key);

  final Product cartProduct;
  final double deviceWidth;

  String totalPricePerEachItem(Product product) {
    double price = 0;
    price = product.quantity * product.price!;
    return price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String productTotalPrice = totalPricePerEachItem(cartProduct);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryPink.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(cartProduct.image!))),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: deviceWidth / 2.1,
                child: Text(
                  cartProduct.title ?? 'N/A',
                  style: productTitle2TextStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: deviceWidth / 2,
                child: Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('\$ ', style: dollarSignTextStyle),
                        Text(
                          "${cartProduct.price}",
                          style: productPrice2TextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    FittedBox(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColor.red.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => context
                                .read<AllProductsBloc>()
                                .add(RemoveFromCartEvent(cartProduct.id!)),
                            icon: const Icon(
                              Icons.delete_forever_rounded,
                              color: AppColor.white,
                            )),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.purple.withOpacity(0.6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$ ',
                              style: dollarSignTextStyle.copyWith(
                                color: AppColor.white,
                              )),
                          Text(
                            productTotalPrice,
                            style: productPrice2TextStyle.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          CounterWidget(
            cartProduct.quantity.toString(),
            onDecrementPressed: () => cartProduct.quantity > 1
                ? context
                    .read<AllProductsBloc>()
                    .add(DecreaseQuantityEvent(cartProduct.id!))
                : context
                    .read<AllProductsBloc>()
                    .add(RemoveFromCartEvent(cartProduct.id!)),
            onIncrementPressed: () => context
                .read<AllProductsBloc>()
                .add(IncreaseQuantityEvent(cartProduct.id!)),
          ),
        ],
      ),
    );
  }
}
