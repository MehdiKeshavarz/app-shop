import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/cached_image.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/screens/product_list_screen.dart';
import 'package:shop_app/utils/string_extension.dart';

class CategoryItemChip extends StatelessWidget {
  final CategoryModel categoryItem;

  const CategoryItemChip({
    super.key,
    required this.categoryItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductListScreen(category: categoryItem);
        }));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: ShapeDecoration(
              color: categoryItem.color.parsToColor(),
              shadows: [
                BoxShadow(
                    color: categoryItem.color.parsToColor(),
                    blurRadius: 25,
                    spreadRadius: -12,
                    offset: const Offset(0.0, 16)),
              ],
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CachedImage(imageUrl: categoryItem.icon),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            categoryItem.title ?? '',
            style: const TextStyle(fontFamily: "sb", fontSize: 14),
          )
        ],
      ),
    );
  }
}
