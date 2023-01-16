import 'package:flutter/material.dart';
import 'package:store_app_using_bloc/core/constants/bottom_navigation_bar_items.dart';

import '../animations/page_transition.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    // const FoodListScreen(),
    // const CartScreen(),
    // const FavoriteScreen(),
    // const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: PageTransition(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          currentIndex = index;
        },
        selectedFontSize: 0,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
