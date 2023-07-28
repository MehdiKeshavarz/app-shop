import 'package:flutter/material.dart';

import '../constants/color_palette.dart';
import '../data/models/variant_model.dart';

class StorageVariantList extends StatefulWidget {
  List<VariantModel> variantList;
  StorageVariantList(this.variantList, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
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
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = index;
                });
              },
              child: Container(
                height: 25,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: (selected == index)
                      ? Border.all(width: 2, color: ColorPalette.blue)
                      : Border.all(width: 1, color: ColorPalette.gery),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      widget.variantList[index].value!,
                      style: const TextStyle(fontSize: 12, fontFamily: 'sb'),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
