import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:widgetly/src/extensions/colors_extensions.dart';

/// A stylized container widget that mimics iOS-style UI elements.
///
/// This widget provides a container with iOS-like styling, including proper
/// border radius handling for items in a list, borders between items, and
/// appropriate background color based on the platform brightness.
///
/// Use this widget to create Cupertino-styled list items or grouped components
/// that follow iOS design guidelines.
///
/// Example usage:
///
/// ```dart
/// // For a single box
/// CupertinoBoxLy(
///   isFirst: true,
///   isLast: true,
///   child: Text('Single Item'),
/// )
///
/// // For a list of boxes
/// Column(
///   children: [
///     CupertinoBoxLy(
///       isFirst: true,
///       child: Text('First Item'),
///     ),
///     CupertinoBoxLy(
///       child: Text('Middle Item'),
///     ),
///     CupertinoBoxLy(
///       isLast: true,
///       child: Text('Last Item'),
///     ),
///   ],
/// )
/// ```
class CupertinoBoxLy extends StatelessWidget {
  /// Creates a Cupertino-styled container with appropriate border styling.
  ///
  /// The [child] widget is required and will be wrapped in this styled container.
  /// Set [isFirst] to true if this is the first item in a grouped list.
  /// Set [isLast] to true if this is the last item in a grouped list.
  ///
  /// If both [isFirst] and [isLast] are true, the container will have rounded corners
  /// on all sides (useful for single items).
  const CupertinoBoxLy({
    super.key,
    required this.child,
    this.isFirst,
    this.isLast,
  });

  /// The widget to be wrapped in the Cupertino-styled container.
  final Widget child;

  /// When true, the container will have rounded corners at the top.
  /// Use this for the first item in a grouped list.
  final bool? isFirst;

  /// When true, the container will have rounded corners at the bottom and no bottom border.
  /// Use this for the last item in a grouped list.
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Add a bottom border for all items except the last one
        border:
            (isLast ?? false) == false
                ? BorderDirectional(
                  bottom: BorderSide(color: ColorsLy.lightGrey, width: 0.5),
                )
                : null,
        // Set background color based on current platform brightness
        color: ColorMethodsLy.white(
          brightness: PlatformDispatcher.instance.platformBrightness,
        ),
        // Determine the border radius based on the item's position
        borderRadius:
            (isFirst ?? false) == false && (isLast ?? false) == false
                ? null // Middle items have no border radius
                : (isFirst ?? false) == true && (isLast ?? false) == true
                ? BorderRadius.all(
                  Radius.circular(10),
                ) // Single items have radius on all corners
                : (isFirst ?? false) == true
                ? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ) // First item has radius on top corners
                : BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ), // Last item has radius on bottom corners
      ),
      // Add consistent padding around the child widget
      child: Padding(padding: const EdgeInsets.all(10), child: child),
    );
  }
}
