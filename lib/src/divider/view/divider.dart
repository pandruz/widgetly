import 'package:flutkit/src/extensions/colors_extensions.dart';
import 'package:flutter/material.dart';

class DividerKit extends StatelessWidget {
  const DividerKit({super.key, this.thickness, this.height});

  final double? thickness;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: thickness ?? 1, height: height, color: ColorsKit.darkGrey);
  }
}
