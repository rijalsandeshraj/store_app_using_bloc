import 'package:flutter/material.dart';

import '../animations/page_transition.dart';

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
      body: PageTransition(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          currentIndex = index;
        },
        selectedFontSize: 0,
        items: returnBottomNavigationBarItems(),
      ),
    );
  }

  returnBottomNavigationBarItems() {
    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        activeIcon: Icon(Icons.home_rounded),
      ),
    ];

    return bottomNavigationBarItems;
  }
}
