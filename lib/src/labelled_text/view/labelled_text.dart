import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:flutter/material.dart';

/// A customizable widget for displaying a label alongside a value.
///
/// This widget arranges a label and value in a row, with options for controlling
/// text overflow, styling, and alignment. It's useful for displaying key-value pairs
/// or form fields with labels.
class LabelledTextLy extends StatelessWidget {
  /// Creates a labelled text widget with a label and value.
  ///
  /// The [label] is required and appears on the left side.
  /// The [value] is displayed on the right side.
  /// Various styling options allow customization of the appearance and behavior.
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

  /// The label text displayed on the left side.
  /// Will be displayed in uppercase.
  final String? label;

  /// The value displayed on the right side.
  /// Can be any type, will be converted to a string.
  final dynamic value;

  /// When true, uses a wider label area (120 pixels wide).
  /// Defaults to false if not specified.
  final bool? largeDescr;

  /// When true, prevents text overflow by scaling down the text.
  /// Defaults to false if not specified.
  final bool? disableOverflow;

  /// The color of the value text.
  /// Defaults to the text theme's default color if not specified.
  final Color? valueColor;

  /// Maximum number of lines the value text can span.
  /// Defaults to 2 if not specified.
  final int? maxLines;

  /// Maximum number of lines the label text can span.
  /// Defaults to 1 if not specified.
  final int? labelMaxLines;

  /// Controls the width of the description area.
  /// The width is calculated as 360 divided by this value.
  /// Defaults to 4 if not specified.
  final double? descriptionWidthDivider;

  /// Font size of the value text.
  /// Defaults to the theme's default text size if not specified.
  final double? valueSize;

  /// Font weight of the value text.
  /// Defaults to normal if not specified.
  final FontWeight? fontWeight;

  /// Alignment of the children along the cross axis.
  /// Defaults to CrossAxisAlignment.end for single-line text, or
  /// CrossAxisAlignment.start for multi-line text.
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
