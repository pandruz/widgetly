import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:widgetly/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StepperLy extends StatelessWidget {
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

  final Color mainColor;
  final int quantity;
  final Function(int) updateQuantity;
  final int? qtyLimit;
  final String? description;
  final bool? outlined;
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
              updateQuantity(quantity + 1 <= qtyLimit! ? quantity + 1 : qtyLimit!);
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
    final width = (MediaQuery.of(context).size.width / (kIsWeb == true ? 10 : 1.9)) / 3;
    final height = MediaQuery.of(context).size.height / 16;
    final isDisabled = quantity == limit;
    final buttonColor =
        outlined == true ? Colors.white.withValues(alpha: isDisabled ? 0.3 : 1.0) : mainColor.withValues(alpha: isDisabled ? 0.3 : 1.0);
    final textColor = outlined == true ? mainColor.withValues(alpha: isDisabled ? 0.3 : 1.0) : Colors.white.withValues(alpha: isDisabled ? 0.3 : 1.0);
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
          color: outlined == true ? (isDisabled ? mainColor.withValues(alpha: 0.3) : mainColor) : Colors.transparent,
        ),
      ),
      child: Center(child: Text(isAddButton ? '+' : '-', style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 28))),
    );
  }

  Widget buildText(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorsLy.darkGrey, width: 2)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text('$quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
      ),
    );
  }

  Widget buildDescription(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (kIsWeb == true ? 0.1 : 0.26),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Text(
          description!.toUpperCase(),
          style: TextStyle(color: ColorsLy.darkGrey, fontSize: 14),
          maxLines: descriptionMaxLines ?? 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
