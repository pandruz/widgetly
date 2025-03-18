import 'package:widgetly/src/gesture_detector/view/gesture_detector.dart';
import 'package:widgetly/src/extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetly/src/text/view/text.dart';
import 'package:widgetly/widgetly.dart';

/// A customizable app bar widget with support for title, navigation, and action buttons.
///
/// This app bar provides a consistent header across the application with
/// customizable colors, back navigation, and trailing actions. It supports both
/// text and widget titles, and handles loading states.
class AppBarLy extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a customizable app bar.
  ///
  /// The [title] parameter is displayed as text in the center of the app bar.
  /// Alternatively, a custom [titleWidget] can be provided for more complex titles.
  /// The [mainColor] defines the background color of the app bar.
  /// The [backAction] callback is triggered when the back button is tapped.
  /// A custom [leadingWidget] can replace the default back button.
  /// When [isLoading] is true, interactive elements are disabled.
  /// The [trailingWidgets] are displayed on the right side of the app bar.
  const AppBarLy({
    super.key,
    this.title,
    this.titleWidget,
    this.mainColor,
    this.backAction,
    this.leadingWidget,
    this.isLoading,
    this.trailingWidgets,
  });

  /// The text displayed in the center of the app bar.
  /// If null, an empty string is displayed unless [titleWidget] is provided.
  final String? title;

  /// An optional widget to display instead of the text title.
  /// If provided, this widget is used instead of the [title].
  final Widget? titleWidget;

  /// The background color of the app bar.
  /// Defaults to blue if not specified.
  final Color? mainColor;

  /// Callback function triggered when the back button is tapped.
  /// If null, no back button is displayed.
  final Function()? backAction;

  /// An optional widget to display instead of the default back button.
  /// If provided, this widget is used in the leading position.
  final Widget? leadingWidget;

  /// When true, interactive elements (like the back button) are disabled.
  /// This is useful during loading or processing operations.
  /// Defaults to false if not specified.
  final bool? isLoading;

  /// A list of widgets to display on the right side of the app bar.
  /// These are typically action buttons.
  final List<Widget>? trailingWidgets;

  @override
  Widget build(BuildContext context) {
    Color color = mainColor ?? WidgetlyConfig().mainColor;
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: AppBar(
        title: buildTitle(color),
        centerTitle: true,
        backgroundColor: color,
        leading: buildLeading(context, color),
        actions: buildActions(context),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget buildTitle(Color color) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child:
          titleWidget ??
          TextLy(
            title ?? '',
            color: color == Colors.black ? Colors.white : null,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
    );
  }

  Widget buildLeading(BuildContext context, Color color) {
    return leadingWidget != null
        ? leadingWidget!
        : backAction == null
        ? SizedBox(
          height: MediaQuery.of(context).size.width * 0.06,
          width: MediaQuery.of(context).size.height * 0.06,
        )
        : GestureDetectorLy(
          onTap: () {
            if ((isLoading ?? false) == false) {
              FocusManager.instance.primaryFocus?.unfocus();
              backAction!();
            }
          },
          child: Opacity(
            opacity: (isLoading ?? false) == false ? 1 : 0.3,
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: color == Colors.black ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
  }

  List<Widget> buildActions(BuildContext context) {
    return trailingWidgets.isNullOrEmpty
        ? [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.06,
            width: MediaQuery.of(context).size.height * 0.06,
          ),
        ]
        : trailingWidgets!;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
