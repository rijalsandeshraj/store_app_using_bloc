import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store_app_using_bloc/bloc/all_products/all_products_bloc.dart';
import 'package:store_app_using_bloc/core/constants/colors.dart';
import 'package:store_app_using_bloc/core/utils/extensions.dart';
import 'package:store_app_using_bloc/presentation/widgets/custom_app_bar.dart';

import '../../../core/constants/text_styles.dart';
import '../../../data/models/product.dart';
import 'cart_product_widget.dart';
import 'total_amount_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final List<Product> cartProducts =
        context.watch<AllProductsBloc>().getCartProducts;
    final double totalPrice = context.read<AllProductsBloc>().getTotalPrice;

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 9),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.white,
          ),
          child: Text(
            cartProducts.length.toString(),
            style: selectedCategoryTextStyle,
          ),
        ),
        title: const Text(
          'My Cart',
          style: primaryTextStyle,
        ),
      ),
      bottomNavigationBar: cartProducts.isEmpty
          ? null
          : TotalAmountWidget(
              totalPrice: totalPrice, containerWidth: deviceWidth * 0.48),
      body: SafeArea(
        child: cartProducts.isEmpty
            ? Center(
                child: SizedBox(
                    height: deviceHeight / 2,
                    child: Lottie.asset('assets/animations/empty_cart.json')))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: cartProducts.length,
                itemBuilder: (_, index) {
                  Product cartProduct = cartProducts[index];
                  return CartProductWidget(
                          cartProduct: cartProduct, deviceWidth: deviceWidth)
                      .fadeAnimation(index * 0.6);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10));
                },
              ),
      ),
    );
  }
}
