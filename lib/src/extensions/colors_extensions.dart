import 'package:material_ui/material_ui.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    final value = int.parse(buffer.toString(), radix: 16);
    return Color.fromARGB(
      (value >> 24) & 0xFF,
      (value >> 16) & 0xFF,
      (value >> 8) & 0xFF,
      value & 0xFF,
    );
  }

  String toHex({bool leadingHashSign = true}) {
    final hex = toARGB32().toRadixString(16).padLeft(8, '0');
    return '${leadingHashSign ? '#' : ''}$hex';
  }
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
