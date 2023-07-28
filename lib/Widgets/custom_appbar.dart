import 'package:flutter/material.dart';

import '../constants/color_palette.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key, required this.textTitle, required this.isSearch})
      : super(key: key);

  final String textTitle;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 20),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            Image.asset('assets/images/icon_apple_blue.png'),
            Expanded(
              child: Text(
                textTitle,
                textAlign: isSearch == true ? TextAlign.end : TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'sb',
                    color: isSearch == true
                        ? ColorPalette.gery
                        : ColorPalette.blue),
              ),
            ),
            const SizedBox(width: 10),
            isSearch == true
                ? Image.asset('assets/images/icon_search.png')
                : const SizedBox(),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
