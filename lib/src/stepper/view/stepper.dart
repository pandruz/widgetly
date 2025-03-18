import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:widgetly/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgetly/src/text/view/text.dart';

/// A customizable stepper widget for incrementing and decrementing values.
///
/// The stepper provides plus/minus buttons, a quantity display, and an optional
/// description label. It supports quantity limits and custom styling.
class StepperLy extends StatelessWidget {
  /// Creates a stepper with increment/decrement buttons and quantity display.
  ///
  /// The [mainColor] defines the primary color of the buttons.
  /// The [quantity] sets the initial value to display.
  /// The [updateQuantity] callback is called when the value changes.
  /// If [qtyLimit] is provided, it sets the maximum value that can be reached.
  /// The [description] is an optional label displayed alongside the stepper.
  /// If [outlined] is true, the buttons will have an outlined style.
  /// The [descriptionMaxLines] controls how many lines the description can span.
  const StepperLy({
    super.key,
    required this.mainColor,
    required this.quantity,
    required this.updateQuantity,
    this.qtyLimit,
    this.description,
    this.outlined,
    this.descriptionMaxLines,
  });

  /// The primary color used for the stepper buttons.
  final Color mainColor;

  /// The current quantity value displayed in the stepper.
  final int quantity;

  /// Callback function triggered when the quantity changes.
  final Function(int) updateQuantity;

  /// Optional upper limit for the quantity value.
  /// If provided, the value cannot exceed this limit.
  final int? qtyLimit;

  /// Optional description label displayed alongside the stepper.
  /// Will be displayed in uppercase.
  final String? description;

  /// When true, the buttons will have an outlined style instead of filled.
  /// Defaults to false if not specified.
  final bool? outlined;

  /// The maximum number of lines the description can span.
  /// Defaults to 1 if not specified.
  final int? descriptionMaxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (description != null) buildDescription(context),
        buildQuantityButton(context, decrement: true),
        Expanded(flex: 3, child: buildText(context)),
        buildQuantityButton(context, decrement: false),
      ],
    );
  }

  Widget buildQuantityButton(BuildContext context, {required bool decrement}) {
    return Expanded(
      flex: 2,
      child: GestureDetectorLy(
        onTap: () {
          if (decrement == false) {
            if (qtyLimit != null && quantity < qtyLimit!) {
              updateQuantity(
                quantity + 1 <= qtyLimit! ? quantity + 1 : qtyLimit!,
              );
            } else {
              updateQuantity(quantity + 1);
            }
          } else {
            if (quantity > 0) {
              updateQuantity(quantity - 1 > 0 ? quantity - 1 : 0);
            }
          }
        },
        onLongPress: () {
          if (decrement == true) {
            updateQuantity(0);
          } else {
            if (qtyLimit != null) {
              updateQuantity(qtyLimit!);
            }
          }
        },
        child: buildButton(context, decrement ? 0 : qtyLimit, !decrement),
      ),
    );
  }

  Widget buildButton(BuildContext context, int? limit, bool isAddButton) {
    final width =
        (MediaQuery.of(context).size.width / (kIsWeb == true ? 10 : 1.9)) / 3;
    final height = MediaQuery.of(context).size.height / 16;
    final isDisabled = quantity == limit;
    final buttonColor =
        outlined == true
            ? Colors.white.withValues(alpha: isDisabled ? 0.3 : 1.0)
            : mainColor.withValues(alpha: isDisabled ? 0.3 : 1.0);
    final textColor =
        outlined == true
            ? mainColor.withValues(alpha: isDisabled ? 0.3 : 1.0)
            : Colors.white.withValues(alpha: isDisabled ? 0.3 : 1.0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(!isAddButton ? 8 : 0),
          bottomLeft: Radius.circular(!isAddButton ? 8 : 0),
          topRight: Radius.circular(isAddButton ? 8 : 0),
          bottomRight: Radius.circular(isAddButton ? 8 : 0),
        ),
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignInside,
          width: 2.5,
          color:
              outlined == true
                  ? (isDisabled ? mainColor.withValues(alpha: 0.3) : mainColor)
                  : Colors.transparent,
        ),
      ),
      child: Center(
        child: TextLy(
          isAddButton ? '+' : '-',
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 28,
        ),
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorsLy.darkGrey, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: TextLy('$quantity', fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }

  Widget buildDescription(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (kIsWeb == true ? 0.1 : 0.26),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: TextLy(
          description!.toUpperCase(),
          color: ColorsLy.darkGrey,
          fontSize: 14,
          maxLines: descriptionMaxLines ?? 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
