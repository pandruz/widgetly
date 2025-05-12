import 'package:flutter/material.dart';
import 'package:widgetly/widgetly.dart';

/// A customizable radio button group widget with support for text or icon options.
///
/// This widget provides a horizontal group of radio buttons with consistent styling
/// and behavior. It supports both text and icon labels for the buttons and
/// maintains the selected state.
class RadioLy extends StatefulWidget {
  /// Creates a radio button group with the specified options.
  ///
  /// The [buttons] parameter defines the labels for each radio option.
  /// The [selected] parameter indicates which button is currently selected (by index).
  /// The [update] callback is triggered when a different option is selected.
  /// The optional [buttonIcons] parameter allows using icons instead of text labels.
  /// The [mainColor] defines the primary color of the radio buttons.
  const RadioLy({
    super.key,
    required this.buttons,
    this.buttonIcons,
    required this.selected,
    required this.update,
    this.mainColor,
  });

  /// The list of labels for each radio button option.
  /// Each string in this list represents one radio button.
  final List<String> buttons;

  /// Optional list of icons to display in place of text labels.
  /// If provided, must have the same length as [buttons].
  final List<IconData>? buttonIcons;

  /// The index of the currently selected radio button.
  /// This should be a valid index in the [buttons] list.
  final int selected;

  /// Callback function triggered when a different option is selected.
  /// The function receives the index of the newly selected button.
  final Function(int) update;

  /// The primary color used for the radio buttons.
  /// Affects the button border color and the background of the selected button.
  /// If not provided, the mainColor from the Widgetly config will be used.
  final Color? mainColor;

  @override
  State<RadioLy> createState() => _RadioLyState();
}

class _RadioLyState extends State<RadioLy> {
  int selected = 0;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildPicker(context);
  }

  /// Builds the complete radio button group
  Widget buildPicker(BuildContext context) {
    // Use provided color or fall back to global config
    Color color = widget.mainColor ?? WidgetlyConfig().mainColor;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          for (String button in widget.buttons)
            buildPickerButton(
              context,
              button,
              widget.buttons.first == button, // isFirst
              widget.buttons.last == button, // isLast
              color,
            ),
        ],
      ),
    );
  }

  /// Builds an individual radio button
  Widget buildPickerButton(
    BuildContext context,
    String button,
    bool isFirst,
    bool isLast,
    Color color,
  ) {
    return GestureDetectorLy(
      onTap: () {
        final int index = widget.buttons.indexOf(button);
        widget.update(index);
        setState(() {
          selected = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          // Selected button uses the main color as background
          color:
              selected == widget.buttons.indexOf(button) ? color : Colors.white,
          border: Border.all(color: color),
          borderRadius:
              isFirst
                  ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
                  : isLast
                  ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                  : null,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                widget.buttonIcons != null &&
                        widget.buttons.indexOf(button) <
                            widget.buttonIcons!.length
                    ? Icon(
                      widget.buttonIcons![widget.buttons.indexOf(button)],
                      color:
                          selected == widget.buttons.indexOf(button)
                              ? Colors.white
                              : color,
                      size: 18,
                    )
                    : TextLy(
                      button,
                      color:
                          selected == widget.buttons.indexOf(button)
                              ? Colors.white
                              : color,
                    ),
          ),
        ),
      ),
    );
  }
}
