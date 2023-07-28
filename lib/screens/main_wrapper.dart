import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_app/constants/color_palette.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/category_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/profile_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedItemIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: IndexedStack(
        index: selectedItemIndex,
        children: getScreens(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                selectedItemIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'sb',
              fontSize: 12,
              color: ColorPalette.blue,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'sb',
              fontSize: 12,
              color: ColorPalette.gery,
            ),
            currentIndex: selectedItemIndex,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/icon_profile.png'),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: ColorPalette.blue,
                          blurRadius: 30,
                          spreadRadius: -7,
                          offset: Offset(0.0, 15.0))
                    ]),
                    child: Image.asset('assets/images/icon_profile_active.png'),
                  ),
                ),
                label: "حساب کاربری",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/icon_basket.png'),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: ColorPalette.blue,
                          blurRadius: 30,
                          spreadRadius: -7,
                          offset: Offset(0.0, 15.0))
                    ]),
                    child: Image.asset('assets/images/icon_basket_active.png'),
                  ),
                ),
                label: "سبدخرید",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/icon_category.png'),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: ColorPalette.blue,
                          blurRadius: 30,
                          spreadRadius: -7,
                          offset: Offset(0.0, 15.0))
                    ]),
                    child:
                        Image.asset('assets/images/icon_category_active.png'),
                  ),
                ),
                label: "دسته بندی",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/icon_home.png'),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: ColorPalette.blue,
                          blurRadius: 30,
                          spreadRadius: -7,
                          offset: Offset(0.0, 15.0))
                    ]),
                    child: Image.asset('assets/images/icon_home_active.png'),
                  ),
                ),
                label: "خانه",
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return [
      const ProfileScreen(),
      const CartScreen(),
      CategoryScreen(),
      const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      )
    ];
  }
}
