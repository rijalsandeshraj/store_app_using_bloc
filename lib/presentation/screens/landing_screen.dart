import 'package:flutter/material.dart';
import 'package:store_app_using_bloc/core/constants/bottom_navigation_bar_items.dart';
import 'package:store_app_using_bloc/presentation/screens/products_screen.dart';

import '../animations/page_transition.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const ProductsScreen(),
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
