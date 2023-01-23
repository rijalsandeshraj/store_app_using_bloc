import 'package:flutter/material.dart';
import 'package:store_app_using_bloc/core/constants/colors.dart';
import 'package:store_app_using_bloc/core/constants/text_styles.dart';
import 'package:store_app_using_bloc/presentation/screens/home_screen/products_screen.dart';
import 'package:store_app_using_bloc/presentation/widgets/custom_app_bar.dart';

import '../../../core/constants/product_categories.dart';
import '../../../data/models/category.dart';
import '../../widgets/app_bar_icon_widget.dart';
import 'popular_products_section.dart';

String productCategoryTitle = 'All Products';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool productsScreenLoaded = false;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;
    // double topPadding = MediaQuery.of(context).padding.top;

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (value) {},
      child: Scaffold(
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                  color: AppColor.grey,
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
                          AssetImage('assets/images/demo_profile_image.jpg')),
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
              if (productsScreenLoaded == false)
                Container(
                  constraints: const BoxConstraints(
                      minHeight: 134, minWidth: double.infinity),
                  margin: const EdgeInsets.only(top: 20),
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
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    Category productCategory = productCategories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          productCategoryTitle = productCategory.title;
                          if (!productsScreenLoaded) {
                            productsScreenLoaded = true;
                          }
                        });
                      },
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
                              color:
                                  productCategoryTitle == productCategory.title
                                      ? AppColor.primaryPink
                                      : AppColor.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              productCategory.title == 'All Products'
                                  ? 'All'
                                  : productCategory.title,
                              style:
                                  productCategoryTitle == productCategory.title
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
                children: <Widget>[
                  Text(
                      productsScreenLoaded == false
                          ? 'Popular'
                          : productCategoryTitle,
                      style: primaryTextStyle),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        productsScreenLoaded = true;
                        productCategoryTitle = 'All Products';
                      });
                    },
                    child: Row(
                      children: const [
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
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: productsScreenLoaded ? 500 : 300,
                child: productsScreenLoaded
                    ? ProductsScreen(
                        titleContainerWidth: deviceWidth / 3,
                      )
                    : const PopularProductsSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
