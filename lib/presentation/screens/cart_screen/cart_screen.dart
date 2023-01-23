import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_using_bloc/bloc/all_products/all_products_bloc.dart';
import 'package:store_app_using_bloc/core/constants/colors.dart';
import 'package:store_app_using_bloc/core/utils/extensions.dart';
import 'package:store_app_using_bloc/presentation/widgets/custom_app_bar.dart';

import '../../../core/constants/text_styles.dart';
import '../../../data/models/product.dart';
import '../../widgets/app_bar_icon_widget.dart';
import 'counter_widget.dart';
import 'total_amount_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final List<Product> cartProducts =
        context.watch<AllProductsBloc>().getCartProducts;
    final double totalPrice = context.read<AllProductsBloc>().getTotalPrice;

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: AppBarIconWidget(
            child: Builder(builder: (context) {
              return IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: AppColor.primaryPink,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            }),
          ),
        ),
        title: const Text(
          'My Cart',
          style: primaryTextStyle,
        ),
      ),
      bottomNavigationBar: TotalAmountWidget(
          totalPrice: totalPrice, containerWidth: deviceWidth * 0.5),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          itemCount: cartProducts.length,
          itemBuilder: (_, index) {
            Product cartProduct = cartProducts[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.white,
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
                      Text(
                        "\$${cartProduct.price}",
                        style: productTitle2TextStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  CounterWidget(
                    cartProduct.quantity.toString(),
                    onDecrementPressed: () => context
                        .read<AllProductsBloc>()
                        .add(DecreaseQuantityEvent(cartProduct.id!)),
                    onIncrementPressed: () => context
                        .read<AllProductsBloc>()
                        .add(IncreaseQuantityEvent(cartProduct.id!)),
                  ),
                ],
              ),
            ).fadeAnimation(index * 0.6);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(padding: EdgeInsets.all(10));
          },
        ),
      ),
    );
  }
}
