import 'dart:ui';

extension ColorParsing on String? {
  Color parsToColor() {
    String colorString = 'ff$this';
    int colorHex = int.parse(colorString, radix: 16);
    return Color(colorHex);
  }
}
