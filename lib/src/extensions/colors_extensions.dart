import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${a.round().toRadixString(16).padLeft(2, '0')}'
      '${r.round().toRadixString(16).padLeft(2, '0')}'
      '${g.round().toRadixString(16).padLeft(2, '0')}'
      '${b.round().toRadixString(16).padLeft(2, '0')}';
}

extension ColorsLy on Color {
  static final darkGrey = HexColor.fromHex('7D7D7D');
  static final lightGrey = HexColor.fromHex('A3A3A3');
}

extension ColorMethodsLy on Color {
  static Color white({Brightness? brightness}) {
    return brightness == Brightness.dark ? Colors.black : Colors.white;
  }
}
