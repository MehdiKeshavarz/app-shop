import 'package:flutter/material.dart';

import '../constants/color_palette.dart';
import '../data/models/property_product_model.dart';

class GetProductProperty extends StatefulWidget {
  final List<PropertyProductModel> propertyList;
  const GetProductProperty({
    super.key,
    required this.propertyList,
  });

  @override
  State<GetProductProperty> createState() => _GetProductPropertyState();
}

class _GetProductPropertyState extends State<GetProductProperty> {
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
                      ':مشخصات فنی',
                      style: TextStyle(fontFamily: 'sb'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(left: 44.0, right: 44.0, top: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: ColorPalette.gery),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.propertyList.length,
                itemBuilder: (context, index) {
                  var property = widget.propertyList[index];
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Text(
                          '${property.title} :',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'sb',
                              color: ColorPalette.gery),
                        ),
                        Flexible(
                          child: Text(
                            '${property.value}',
                            style:
                                const TextStyle(fontSize: 14, fontFamily: 'sb'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
