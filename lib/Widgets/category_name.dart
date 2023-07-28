import 'package:flutter/material.dart';

import '../constants/color_palette.dart';

class CategoryName extends StatelessWidget {
  const CategoryName({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Text(
            categoryName,
            style: const TextStyle(
              color: ColorPalette.gery,
              fontFamily: 'sb',
              fontSize: 12,
            ),
          ),
          const Spacer(),
          const Text(
            'مشاهده همه',
            style: TextStyle(
              color: ColorPalette.blue,
              fontFamily: 'sb',
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/images/icon_left_category.png'),
        ],
      ),
    );
  }
}
