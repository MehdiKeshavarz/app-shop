import 'package:flutter/material.dart';

import '../constants/color_palette.dart';
import '../data/models/product_model.dart';

class GetProductDescription extends StatefulWidget {
  final ProductModel product;

  const GetProductDescription({
    super.key,
    required this.product,
  });

  @override
  State<GetProductDescription> createState() => _GetProductDescriptionState();
}

class _GetProductDescriptionState extends State<GetProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44.0, right: 44.0, top: 15),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: ColorPalette.gery),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_category.png'),
                    const SizedBox(width: 5),
                    const Text(
                      'مشاهده',
                      style:
                          TextStyle(fontFamily: 'sm', color: ColorPalette.blue),
                    ),
                    const Spacer(),
                    const Text(
                      ':توضیحات محصول',
                      style: TextStyle(fontFamily: 'sb'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(left: 44.0, right: 44.0, top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: ColorPalette.gery),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.product.description!,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontFamily: 'sb', fontSize: 14, height: 1.8),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
