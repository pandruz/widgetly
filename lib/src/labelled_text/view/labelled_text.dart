import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:flutter/material.dart';

class LabelledTextLy extends StatelessWidget {
  const LabelledTextLy({
    super.key,
    required this.label,
    this.value,
    this.largeDescr,
    this.disableOverflow,
    this.valueColor,
    this.maxLines,
    this.labelMaxLines,
    this.descriptionWidthDivider,
    this.valueSize,
    this.fontWeight,
    this.crossAxisAlignment,
  });

  final String? label;
  final dynamic value;
  final bool? largeDescr;
  final bool? disableOverflow;
  final Color? valueColor;
  final int? maxLines;
  final int? labelMaxLines;
  final double? descriptionWidthDivider;
  final double? valueSize;
  final FontWeight? fontWeight;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? ((maxLines ?? 0) < 2 ? CrossAxisAlignment.end : CrossAxisAlignment.start),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildDescription(), buildValue()],
    );
  }

  Widget buildValue() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: disableOverflow == true ? FittedBox(fit: BoxFit.scaleDown, child: buildText()) : buildText())],
      ),
    );
  }

  Widget buildText() {
    return Text(
      '$value',
      style: TextStyle(color: valueColor, fontSize: valueSize, fontWeight: fontWeight),
      maxLines: maxLines ?? 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
      child: SizedBox(
        width: largeDescr == true ? 120 : 360 / (descriptionWidthDivider ?? 4),
        child: Text(
          (label ?? '').isEmpty ? '-' : label!.toUpperCase(),
          style: TextStyle(color: ColorsLy.darkGrey, fontSize: 14),
          maxLines: labelMaxLines ?? 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
