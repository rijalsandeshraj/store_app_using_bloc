import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:store_app_using_bloc/core/utils/show_custom_snack_bar.dart';

import '../../../bloc/all_products/all_products_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/snack_bar_messages.dart';
import '../../../core/constants/text_styles.dart';
import '../../../data/models/product.dart';

class FavoriteProductWidget extends StatelessWidget {
  const FavoriteProductWidget({
    Key? key,
    required this.favoriteProduct,
    required this.deviceWidth,
  }) : super(key: key);

  final Product favoriteProduct;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
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
              child: CachedNetworkImage(
                imageUrl: favoriteProduct.image!,
                fit: BoxFit.contain,
                placeholder: (context, url) => FittedBox(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child:
                        Lottie.asset('/assets/animations/image_loading.json'),
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Image.asset(
                    'assets/images/no_image_available.jpg',
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: deviceWidth / 2.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoriteProduct.title ?? 'N/A',
                  style: productTitle2TextStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                RatingBar(
                  initialRating: favoriteProduct.rating!.rate ?? 0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('\$ ', style: dollarSignTextStyle),
                        Text(
                          "${favoriteProduct.price}",
                          style: productPrice2TextStyle,
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: favoriteProduct.addedToCart
                            ? AppColor.green.withOpacity(0.8)
                            : AppColor.grey.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: favoriteProduct.addedToCart
                              ? () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showCustomSnackBar(
                                        context, itemAlreadyAddedToCart);
                                  });
                                }
                              : () {
                                  context
                                      .read<AllProductsBloc>()
                                      .add(AddToCartEvent(favoriteProduct.id!));
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showCustomSnackBar(
                                        context, itemAddedToCart);
                                  });
                                },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColor.white,
                            size: 20,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.lightBlue, AppColor.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 0.8],
                tileMode: TileMode.repeated,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context
                      .read<AllProductsBloc>()
                      .add(RemoveFromFavoritesEvent(favoriteProduct.id!));
                  showCustomSnackBar(context, 'Item Removed from Favorites!');
                },
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: AppColor.red,
                  size: 36,
                )),
          )
        ],
      ),
    );
  }
}
