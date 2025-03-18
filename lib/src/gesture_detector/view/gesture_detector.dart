import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable gesture detector that handles tap and long press interactions.
///
/// This widget extends the functionality of Flutter's standard GestureDetector
/// with improved handling of combined tap and long press actions, and optional
/// haptic feedback.
class GestureDetectorLy extends StatelessWidget {
  /// Creates a gesture detector with customized tap and long press handling.
  ///
  /// The [child] widget is required and will respond to the specified gestures.
  /// The [onTap] callback is triggered when the user taps on the widget.
  /// The [onLongPress] callback is triggered when the user long-presses the widget.
  /// If [vibrate] is true, haptic feedback will be provided on interaction.
  const GestureDetectorLy({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.vibrate,
  });

  /// The widget that will respond to gestures.
  final Widget child;

  /// Callback function triggered when the user taps the widget.
  /// If both [onTap] and [onLongPress] are provided, this is called on tap up.
  /// If only [onTap] is provided, this is called on tap down.
  final Function()? onTap;

  /// Callback function triggered when the user long-presses the widget.
  final Function()? onLongPress;

  /// When true, provides haptic feedback when interacting with the widget.
  /// Defaults to false if not specified.
  final bool? vibrate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null && onLongPress == null) {
          if (vibrate == true) {
            HapticFeedback.heavyImpact();
          }
          onTap!();
        }
      },
      onTapUp: (details) {
        if (onLongPress != null && onTap != null) {
          if (vibrate == true) {
            HapticFeedback.heavyImpact();
          }
          onTap!();
        }
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress!();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
