import 'dart:math';

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
    // double topPadding = MediaQuery.of(context).padding.top;

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
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
              child: MasonryGridView.count(
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
                                'https://source.unsplash.com/random/?Product&$index'),
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
                                style: productTitleTextStyle,
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
                                style: productPriceTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
