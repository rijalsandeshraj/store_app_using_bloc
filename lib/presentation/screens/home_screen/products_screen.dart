import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:store_app_using_bloc/core/constants/snack_bar_messages.dart';
import 'package:store_app_using_bloc/core/utils/show_custom_snack_bar.dart';
import 'package:store_app_using_bloc/data/store_repository.dart';
import 'package:store_app_using_bloc/presentation/screens/home_screen/home_screen.dart';

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
    if (!productsFetched) {
      BlocProvider.of<AllProductsBloc>(context).add(GetAllProductsEvent());
    }
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
            List<Product> productsList = [];
            switch (productCategoryTitle) {
              case 'All Products':
                productsList = state.productList!;
                break;
              case 'Electronics':
                productsList = state.productList!
                    .where(
                        (e) => e.category == productCategoryTitle.toLowerCase())
                    .toList();
                break;
              case 'Jewellery':
                productsList = state.productList!
                    .where((e) => e.category == 'jewelery')
                    .toList();
                break;
              case 'Men\'s Clothing':
                productsList = state.productList!
                    .where(
                        (e) => e.category == productCategoryTitle.toLowerCase())
                    .toList();
                break;
              case 'Women\'s Clothing':
                productsList = state.productList!
                    .where(
                        (e) => e.category == productCategoryTitle.toLowerCase())
                    .toList();
                break;
              default:
                productsList = state.productList!;
                break;
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2 / 3.2,
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
                        top: 10,
                        bottom: 80,
                        child: SizedBox(
                          width: widget.titleContainerWidth - 10,
                          child: CachedNetworkImage(
                            imageUrl: product.image!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => FittedBox(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryPink.withOpacity(0.3),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset(
                                  'assets/images/no_image_available.jpg',
                                  height: widget.titleContainerWidth),
                            ),
                          ),
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
                              const SizedBox(height: 2),
                              RatingBar(
                                initialRating: product.rating!.rate ?? 0,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 15,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    half: const Icon(
                                      Icons.star_half,
                                      color: Colors.orange,
                                    ),
                                    empty: const Icon(
                                      Icons.star_outline,
                                      color: Colors.orange,
                                    )),
                                onRatingUpdate: (value) {},
                              ),
                              const SizedBox(height: 2),
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
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: product.addedToCart
                              ? () {
                                  showCustomSnackBar(
                                      context, itemAlreadyAddedToCart);
                                }
                              : () {
                                  context
                                      .read<AllProductsBloc>()
                                      .add(AddToCartEvent(product.id!));

                                  showCustomSnackBar(context, itemAddedToCart);
                                },
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
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(product.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded),
                          color: AppColor.red,
                          onPressed: product.isFavorite
                              ? () {
                                  context.read<AllProductsBloc>().add(
                                      RemoveFromFavoritesEvent(product.id!));
                                  showCustomSnackBar(
                                      context, itemRemovedFromFavorites);
                                }
                              : () {
                                  context
                                      .read<AllProductsBloc>()
                                      .add(AddToFavoritesEvent(product.id!));
                                  showCustomSnackBar(
                                      context, itemAddedToFavorites);
                                },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is AllProductsErrorState) {
            String error = state.error;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomSnackBar(context, error, taskSuccess: false);
            });
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  error,
                  style: errorTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text('Retry',
                    style: errorTextStyle, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: widget.titleContainerWidth - 100,
                  backgroundColor: AppColor.white.withOpacity(0.6),
                  child: IconButton(
                    icon: const Icon(Icons.rotate_right_rounded),
                    color: AppColor.green,
                    iconSize: 40,
                    onPressed: () => context
                        .read<AllProductsBloc>()
                        .add(GetAllProductsEvent()),
                  ),
                ),
              ],
            ));
          } else {
            return const Center(
                child: Text(
              'An error occurred!',
              style: errorTextStyle,
            ));
          }
        },
      ),
    );
  }
}
