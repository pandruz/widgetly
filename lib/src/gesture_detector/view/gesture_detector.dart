import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestureDetectorKit extends StatelessWidget {
  const GestureDetectorKit({super.key, required this.child, this.onTap, this.onLongPress, this.vibrate});

  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;
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
