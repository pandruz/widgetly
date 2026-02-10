import 'package:widgetly/src/button/view/button.dart';
import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:widgetly/src/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:widgetly/src/text/view/text.dart';

/// A customizable placeholder widget for empty states or loading screens.
///
/// The placeholder displays an icon, text message, and an optional reset button.
/// It can be used to show empty states, error messages, or loading indicators.
class PlaceholderLy extends StatelessWidget {
  /// Creates a placeholder with an icon and text message.
  ///
  /// The [placeholderText] is required and appears below the icon.
  /// The [icon] is optional and defaults to a search icon if not provided.
  /// If [resetAction] is provided, a reset button will be displayed.
  /// The [resetButtonLabel] and [resetButtonColor] customize the reset button.
  /// The [mainColor] affects the color of the icon and text.
  /// The [paddingTop] and [paddingBottom] control the spacing around the placeholder.
  const PlaceholderLy({
    super.key,
    this.icon,
    required this.placeholderText,
    this.resetAction,
    this.resetButtonLabel,
    this.resetButtonColor,
    this.mainColor,
  });

  /// The icon displayed at the top of the placeholder.
  /// Defaults to a search icon (Icons.search) if not provided.
  final IconData? icon;

  /// The text message displayed below the icon.
  final String placeholderText;

  /// Optional callback function for the reset button.
  /// If provided, a reset button will be displayed below the text.
  final Function()? resetAction;

  /// Custom label for the reset button.
  /// Defaults to "Reset" (or its localized equivalent) if not provided.
  final String? resetButtonLabel;

  /// Color of the reset button.
  /// Defaults to red if not provided.
  final Color? resetButtonColor;

  /// The color used for the icon and text.
  /// Defaults to black for the icon and dark grey for the text if not provided.
  final Color? mainColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.widthOf(context),
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildIcon(),
            buildText(),
            if (resetAction != null) buildReset(),
          ],
        ),
      ),
    );
  }

  Widget buildIcon() {
    return Icon(
      icon ?? Icons.search,
      color: mainColor ?? Colors.black,
      size: 90,
    );
  }

  Widget buildText() {
    return Padding(
      padding: const .only(top: 10),
      child: TextLy(
        placeholderText,
        color: mainColor ?? ColorsLy.darkGrey,
        fontSize: 30,
        fontWeight: .w500,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildReset() {
    return Padding(
      padding: const .only(top: 20),
      child: ButtonLy(
        label: resetButtonLabel ?? LocalizationLy.instance.translate('Reset'),
        buttonFunc: () {
          resetAction!();
        },
        mainColor: resetButtonColor ?? Colors.red,
        showOutline: true,
      ),
    );
  }
}
