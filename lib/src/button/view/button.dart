import 'package:flutter/material.dart';
import 'package:widgetly/widgetly.dart';

/// A customizable button widget with different states and styling options.
///
/// The button supports outlined and filled styles, loading state, and
/// customizable colors. It automatically handles tap events and provides
/// a consistent appearance across the application.
class ButtonLy extends StatelessWidget {
  /// Creates a styled button with text and optional action.
  ///
  /// The [label] is displayed as the button text.
  /// The [mainColor] defines the primary color of the button.
  /// The [textColor] defines the color of the text and the icon.
  /// The [buttonFunc] is called when the button is tapped.
  /// If [showOutline] is true, the button will have an outlined style.
  /// If [isLoading] is true, the button will display a loading indicator.
  const ButtonLy({
    super.key,
    required this.label,
    this.mainColor,
    this.textColor,
    this.buttonFunc,
    this.showOutline,
    this.isLoading,
    this.icon,
  });

  /// The text displayed on the button.
  /// Will be displayed in uppercase if the button is actionable.
  final String label;

  /// The primary color of the button.
  /// Affects background color (or outline color if [showOutline] is true)
  /// and text color based on contrast. If not provided, the mainColor from
  /// the Widgetly config (or its default) will be used.
  final Color? mainColor;

  /// The color that will be assigned to the text and the icon.
  /// If not provided, black will be used (unless mainColor is set to black
  /// and outlined is not true, in which case white will be used).
  final Color? textColor;

  /// Callback function triggered when the button is tapped.
  /// If null, the button will appear disabled (but still visible).
  final Function()? buttonFunc;

  /// When true, the button will have an outlined style instead of filled.
  /// Defaults to false if not specified.
  final bool? showOutline;

  /// When true, the button displays a loading indicator instead of text.
  /// Defaults to false if not specified.
  final bool? isLoading;

  /// If set, the icon will be placed to the left of the label.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Color color = mainColor ?? WidgetlyConfig().mainColor;
    return GestureDetectorLy(
      onTap: () {
        if (buttonFunc != null) {
          buttonFunc!();
        }
      },
      child: Container(
        height: 45,
        decoration: buildDecoration(color),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: isLoading == true ? buildLoading(color) : buildButton(color),
          ),
        ),
      ),
    );
  }

  Widget buildButton(Color color) {
    final Color itemsColor =
        showOutline == true
            ? (textColor ?? color)
            : textColor != null
            ? textColor!
            : color == Colors.white
            ? Colors.black
            : Colors.white;
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(icon, color: itemsColor, size: 26),
              ),
            TextLy(
              buttonFunc != null ? label.toUpperCase() : label,
              color: itemsColor,
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading(Color color) {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        color: color == Colors.white ? Colors.black : Colors.white,
      ),
    );
  }

  BoxDecoration buildDecoration(Color color) {
    return BoxDecoration(
      color: showOutline == true ? Colors.transparent : color,
      border: Border.all(color: color, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
