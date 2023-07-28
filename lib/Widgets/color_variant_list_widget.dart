import 'package:flutter/material.dart';

import '../data/models/variant_model.dart';

class ColorVariantList extends StatefulWidget {
  List<VariantModel> variantList;
  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = index;
                });
              },
              child: Container(
                height: 26,
                width: (selected == index) ? 46 : 26,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: (selected == index)
                      ? Text(
                          widget.variantList[index].name!,
                          style: const TextStyle(
                              fontFamily: 'sb', color: Colors.white),
                        )
                      : const SizedBox(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
