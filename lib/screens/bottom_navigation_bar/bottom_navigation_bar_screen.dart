import 'package:flutter/material.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/screens/cart/cart_screen.dart';
import 'package:flutter_technical_task/screens/favorites/favorite_screen.dart';
import 'package:flutter_technical_task/screens/home/home_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() => currentIndex = index);
            },
            rippleColor: AppColors.primaryLight,
            hoverColor: AppColors.primaryLight,
            gap: 8,
            iconSize: 24,
            duration: const Duration(milliseconds: 250),
            color: Colors.grey,
            activeColor: AppColors.primaryColor,
            tabBackgroundColor: AppColors.primaryLight,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite_rounded,
                text: 'Favorites',
              ),
              GButton(
                icon: Icons.shopping_cart_rounded,
                text: 'Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}