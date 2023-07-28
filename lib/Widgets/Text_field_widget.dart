import 'package:flutter/material.dart';

import '../constants/color_palette.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
            fontFamily: 'sm', fontSize: 18, color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 3, color: ColorPalette.blue),
        ),
      ),
    );
  }
}
