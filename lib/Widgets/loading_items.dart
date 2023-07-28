import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/constants/color_palette.dart';

class LoadingItems extends StatelessWidget {
  final String title;
  const LoadingItems({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        LoadingAnimationWidget.beat(color: ColorPalette.blue, size: 32),
        const SizedBox(
          height: 16,
        ),
        Text(title, style: const TextStyle(fontSize: 18, fontFamily: 'sb'))
      ],
    );
  }
}
