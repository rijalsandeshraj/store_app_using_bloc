import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store_app_using_bloc/bloc/all_products/all_products_bloc.dart';
import 'package:store_app_using_bloc/core/constants/colors.dart';
import 'package:store_app_using_bloc/core/utils/extensions.dart';
import 'package:store_app_using_bloc/presentation/widgets/custom_app_bar.dart';

import '../../../core/constants/text_styles.dart';
import '../../../data/models/product.dart';
import 'favorite_product_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final List<Product> favoriteProducts =
        context.watch<AllProductsBloc>().getFavoriteProducts;

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: FittedBox(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white,
              ),
              child: Text(
                favoriteProducts.length.toString(),
                style: selectedCategoryTextStyle,
              ),
            ),
          ),
        ),
        title: const Text(
          'Favorites',
          style: primaryTextStyle,
        ),
      ),
      body: SafeArea(
        child: favoriteProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: deviceHeight / 2.5,
                        child: Lottie.asset(
                            'assets/animations/empty_favorites.json')),
                    Text(
                      'No Items Added\nto Favorites',
                      style: primaryTextStyle.copyWith(color: AppColor.red),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: favoriteProducts.length,
                itemBuilder: (_, index) {
                  Product favoriteProduct = favoriteProducts[index];
                  return FavoriteProductWidget(
                          favoriteProduct: favoriteProduct,
                          deviceWidth: deviceWidth)
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
