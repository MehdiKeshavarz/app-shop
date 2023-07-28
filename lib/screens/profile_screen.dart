import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/custom_appbar.dart';
import 'package:shop_app/constants/color_palette.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(textTitle: 'حساب کاربری', isSearch: false),
            const Text(
              'مهدی کشاورز',
              style: TextStyle(fontSize: 16, fontFamily: 'sb'),
            ),
            const Text(
              '09373068747',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'sm', color: ColorPalette.gery),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 40,
                runSpacing: 20,
                children: [
                  Container(height: 50, width: 50, color: Colors.blue),
                  Container(height: 50, width: 50, color: Colors.blue),
                  Container(height: 50, width: 50, color: Colors.blue),
                  Container(height: 50, width: 50, color: Colors.blue),
                  Container(height: 50, width: 50, color: Colors.blue),
                  Container(height: 50, width: 50, color: Colors.blue),
                  Container(height: 50, width: 50, color: Colors.blue),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                  fontSize: 12, color: ColorPalette.gery, fontFamily: 'sm'),
            ),
            const Text(
              'v-1.0.00',
              style: TextStyle(
                  fontSize: 12, color: ColorPalette.gery, fontFamily: 'sm'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
