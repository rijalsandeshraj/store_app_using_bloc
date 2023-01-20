import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class PopularProductsSection extends StatefulWidget {
  const PopularProductsSection({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularProductsSection> createState() => _PopularProductsSectionState();
}

class _PopularProductsSectionState extends State<PopularProductsSection> {
  // bool isLoading = true;
  // ValueNotifier<bool> imageLoadedNotifier = ValueNotifier<bool>(false);

  // @override
  // void initState() {
  //   super.initState();
  //   imageLoadedNotifier.addListener(() {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return
        // isLoading
        //     ? Center(
        //         child: SizedBox(
        //             width: MediaQuery.of(context).size.width / 3,
        //             child: Lottie.asset('assets/animations/loading.json')))
        //     :
        MasonryGridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 10),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: 10,
            itemBuilder: (context, index) {
              int randomNumber = Random().nextInt(200) + 10;
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://source.unsplash.com/random/?Product&$index',
                        // loadingBuilder: (BuildContext context, Widget image,
                        //     ImageChunkEvent? loadingProgress) {
                        //   if (loadingProgress == null) {
                        //     imageLoadedNotifier.value = true;
                        //     return image;
                        //   }
                        //   return const SizedBox();
                        // },
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          'Product ${index + 1}',
                          style: productTitle1TextStyle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          '\$ $randomNumber',
                          style: productPrice1TextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
  }
}
