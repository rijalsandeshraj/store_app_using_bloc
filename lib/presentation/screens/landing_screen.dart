import 'package:flutter/material.dart';
import 'package:store_app_using_bloc/core/constants/bottom_navigation_bar_items.dart';
import 'package:store_app_using_bloc/presentation/screens/home_screen/home_screen.dart';

import '../animations/page_transition.dart';
import 'cart_screen/cart_screen.dart';
import 'favorite_screen/favorite_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    // const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransition(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedFontSize: 0,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
