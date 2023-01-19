import 'package:flutter/material.dart';
import 'package:store_app_using_bloc/core/constants/colors.dart';
import 'package:store_app_using_bloc/core/constants/text_styles.dart';
import 'package:store_app_using_bloc/presentation/screens/home_screen/product_categories_widget.dart';
import 'package:store_app_using_bloc/presentation/screens/home_screen/products_screen.dart';
import 'package:store_app_using_bloc/presentation/widgets/custom_app_bar.dart';

import '../../widgets/app_bar_icon_widget.dart';
import 'popular_products_section.dart';

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
            const ProductCategoriesWidget(),
            Row(
              children: <Widget>[
                const Text('Popular', style: primaryTextStyle),
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      productsScreenLoaded = true;
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
              height: 300,
              child: productsScreenLoaded
                  ? const ProductsScreen()
                  : const PopularProductsSection(),
            ),
          ],
        ),
      ),
    );
  }
}