import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:widgetly/src/gesture_detector/view/gesture_detector.dart';
import 'package:widgetly/src/modal/modal_repository.dart';
import 'package:widgetly/src/picker/view/item_selector.dart';
import 'package:flutter/material.dart';
import 'package:widgetly/src/text/view/text.dart';

/// A customizable dropdown picker widget that displays selectable options in a modal sheet.
///
/// The picker shows the currently selected value and opens a modal with all available
/// options when tapped. It supports optional labeling and custom styling.
// ignore: must_be_immutable
class PickerLy extends StatefulWidget {
  /// Creates a picker with selectable options.
  ///
  /// The [selectedValue] is the currently selected item to display.
  /// The [values] are the available options that can be selected.
  /// The [updateValue] callback is called when a new option is selected.
  /// The [label] is an optional description displayed next to the picker.
  /// The [mainColor] defines the primary color for the modal header.
  /// The [deleteAction] is an optional callback to add a delete button.
  PickerLy({
    super.key,
    this.label,
    this.modalTitle,
    this.labelMaxLines,
    required this.selectedValue,
    this.mainColor,
    required this.values,
    required this.updateValue,
    this.deleteAction,
  });

  /// Optional label text displayed next to the picker.
  /// Will be displayed in uppercase.
  final String? label;

  /// Title text displayed in the modal header when the picker is opened.
  /// Defaults to the [label] value if not provided.
  final String? modalTitle;

  /// Maximum number of lines the label text can span.
  /// Defaults to 1 if not specified.
  final int? labelMaxLines;

  /// The primary color used for the modal header.
  /// Defaults to blue if not specified.
  final Color? mainColor;

  /// Collection of items that can be selected in the picker.
  final Iterable<dynamic> values;

  /// Callback function triggered when a new value is selected.
  final Function(dynamic element) updateValue;

  /// Optional callback function for a delete button.
  /// If provided, a delete button will be displayed next to the picker.
  final Function()? deleteAction;

  /// The currently selected value to display in the picker.
  dynamic selectedValue;

  @override
  State<PickerLy> createState() => _CustomPickerState();
}

class _CustomPickerState extends State<PickerLy> {
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [if (widget.label != null) buildLabel(), buildValue()],
      ),
    );
  }

  Widget buildValue() {
    return Expanded(
      flex: 4,
      child: SizedBox(
        width:
            widget.label == null
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 1.9,
        height: 45,
        child: Row(
          children: [
            buildPicker(context),
            if (widget.deleteAction != null) buildDelete(),
          ],
        ),
      ),
    );
  }

  Widget buildLabel() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.5,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextLy(
          widget.label!.toUpperCase(),
          color: ColorsLy.darkGrey,
          fontSize: 14,
          maxLines: widget.labelMaxLines ?? 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget buildPicker(BuildContext context) {
    return Expanded(
      child: GestureDetectorLy(
        onTap: () {
          ModalRepository.shared.showBottomSheet(
            context: context,
            mainColor: widget.mainColor,
            bottomSheet: ItemSelectorLy(
              label: widget.label,
              selectedValue: widget.selectedValue,
              values: widget.values,
              updateValue: (dynamic element) {
                widget.updateValue(element);
              },
            ),
            title: widget.modalTitle ?? widget.label,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorsLy.darkGrey, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: TextLy(
                      widget.selectedValue == null
                          ? '-'
                          : '${widget.selectedValue}',
                      fontSize: 24,
                      color: Colors.black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      height: 55,
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDelete() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetectorLy(
        onTap: () async {
          if (widget.deleteAction != null) {
            await widget.deleteAction!();
          }
          setState(() {
            widget.selectedValue = null;
          });
        },
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.close, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
