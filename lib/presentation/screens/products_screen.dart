import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:store_app_using_bloc/core/constants/colors.dart';
import 'package:store_app_using_bloc/core/constants/product_categories.dart';
import 'package:store_app_using_bloc/core/constants/text_styles.dart';
import 'package:store_app_using_bloc/data/models/category.dart';
import 'package:store_app_using_bloc/presentation/widgets/custom_app_bar.dart';

import '../widgets/app_bar_icon_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;

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
                  Icons.view_headline_rounded,
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
          'Home',
          style: primaryTextStyle,
        ),
        actions: [
          AppBarIconWidget(
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.shopping_basket_rounded,
                color: AppColor.primaryPink,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: AppBarIconWidget(
              child: GestureDetector(
                child: const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/demo_profile_image.jpg')),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 15, top: 100, right: 15),
        children: [
          Row(
            children: [
              SizedBox(
                height: 45,
                width: deviceWidth - 80,
                child: TextField(
                  style: secondaryTextStyle,
                  cursorColor: AppColor.grey,
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: secondaryTextStyle,
                      filled: true,
                      fillColor: AppColor.white,
                      contentPadding: const EdgeInsets.only(left: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.search_rounded),
                        color: AppColor.grey,
                      )),
                  onChanged: (query) {
                    // if (query.isNotEmpty) {
                    //   if (menuController.currentHomeIndex.value != 1) {
                    //     menuController.currentHomeIndex(1);
                    //   }
                    //   menuController.getMenuItemsBySearch(
                    //       query, UserSession.branchId);
                    //   setState(() {});
                    // }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primaryPink,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune_rounded),
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: deviceHeight / 5.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 127, 126, 201),
                  Color.fromARGB(255, 128, 200, 225),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.3, 0.9],
                tileMode: TileMode.repeated,
              ),
            ),
          ),
          Container(
            height: 42,
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                Category productCategory = productCategories[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          productCategory.iconData,
                          color: productCategory.isSelected
                              ? AppColor.primaryPink
                              : AppColor.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          productCategory.title,
                          style: productCategory.isSelected
                              ? selectedCategoryTextStyle
                              : secondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: const <Widget>[
              Text('Popular', style: primaryTextStyle),
              Spacer(),
              Text(
                'View All Products',
                style: sectionActionTextStyle,
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColor.grey,
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 300,
            child: GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                // repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  child: StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: Column(
                      children: <Widget>[
                        Image.network(images[index]),
                        const Text("Some text"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> images = [
  "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
  "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
  "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
  "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
  "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
  "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
  "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",
];
