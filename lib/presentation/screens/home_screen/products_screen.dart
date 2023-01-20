import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store_app_using_bloc/core/utils/show_custom_snack_bar.dart';

import '../../../bloc/all_products/all_products_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, required this.titleContainerWidth})
      : super(key: key);

  final double titleContainerWidth;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllProductsBloc>(context).add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsLoadingState) {
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          } else if (state is AllProductsLoadedState) {
            List<Product> productsList = state.productList!;
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2 / 3,
              ),
              itemCount: productsList.length,
              itemBuilder: (_, index) {
                Product product = productsList[index];
                return InkWell(
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.white,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: SizedBox(
                          width: widget.titleContainerWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title ?? 'Product',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: productTitle2TextStyle,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('\$ ', style: dollarSignTextStyle),
                                  Text(
                                    product.price != null
                                        ? '${product.price}'
                                        : '0.0',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: productPrice2TextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 75,
                        child: SizedBox(
                          width: widget.titleContainerWidth - 10,
                          child: CachedNetworkImage(
                            imageUrl: product.image!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const FittedBox(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryPink,
                                ),
                              ),
                            ),
                            // errorWidget: (context, url, error) => Center(
                            //   child:
                            //       Image.asset('assets/logo.png', height: 150),
                            // ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: AppColor.primaryPink,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add_rounded,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.favorite_rounded),
                          color: AppColor.red,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is AllProductsErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomSnackBar(context, state.error, taskSuccess: false);
            });
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          } else {
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Lottie.asset('assets/animations/loading.json')));
          }
        },
      ),
    );
  }
}
