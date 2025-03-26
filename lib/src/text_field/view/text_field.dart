import 'dart:io';
import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:widgetly/src/localization/localization.dart';
import 'package:widgetly/widgetly.dart';

/// A customizable text field widget with optional label and various input controls.
///
/// This widget provides a complete text input solution with support for features like
/// obscuring text, read-only mode, custom colors, and more.
class TextFieldLy extends StatefulWidget {
  /// Creates a customizable text field.
  ///
  /// The text field can have an optional [label], custom styling,
  /// and various callback functions for user interactions.
  const TextFieldLy({
    super.key,
    this.label,
    this.hintText,
    this.initialValue,
    this.updateValue,
    this.obscureTextFunction,
    this.submitAction,
    this.descriptionLowercased,
    this.obscureText,
    this.readOnly,
    this.textCapitalization,
    this.height,
    this.mainColor,
    this.textInputAction,
    this.keyboardType,
    this.textEditingController,
    this.textAlignVertical,
    this.maxLines,
  });

  /// Optional label displayed next to the text field.
  /// By default, displayed in uppercase unless [descriptionLowercased] is true.
  final String? label;

  /// Placeholder text displayed when the text field is empty.
  final String? hintText;

  /// Initial value of the text field.
  final dynamic initialValue;

  /// Callback function triggered when the text field value changes.
  final Function(String value)? updateValue;

  /// Callback function to toggle the visibility of the text (for password fields).
  /// Used when [obscureText] is provided.
  final Function()? obscureTextFunction;

  /// Callback function triggered when the user submits the text field.
  final Function(String value)? submitAction;

  /// When true, the label is displayed in lowercase. Otherwise, it's in uppercase.
  /// Defaults to false if not specified.
  final bool? descriptionLowercased;

  /// When true, the text is obscured (for password input).
  /// Defaults to false if not specified.
  final bool? obscureText;

  /// When true, the text field cannot be edited.
  /// Defaults to false if not specified.
  final bool? readOnly;

  /// When true, text is automatically capitalized.
  /// Defaults to false if not specified.
  final bool? textCapitalization;

  /// Height of the text field.
  /// Defaults to 55 if not specified.
  final double? height;

  /// The primary color for the text field focus and cursor.
  /// Defaults to blue if not specified.
  final Color? mainColor;

  /// The keyboard action button type (e.g., next, done, send).
  final TextInputAction? textInputAction;

  /// The type of keyboard to display (e.g., text, number, email).
  final TextInputType? keyboardType;

  /// Optional controller for the text field.
  /// If not provided, an internal controller is created.
  final TextEditingController? textEditingController;

  /// Vertical alignment of text within the text field.
  /// Defaults to TextAlignVertical.top if not specified.
  final TextAlignVertical? textAlignVertical;

  /// Maximum number of lines for a multiline TextField.
  /// If set, the keyboard will be automatically set to
  /// TextInputType.multiline, and will be removed any
  /// obsfuscation implementation, since Flutter doesn't
  /// allow maxLines and obscureText to coexist. Moreover,
  /// if height is not specified, it will be automatically
  /// set based on the number of maxLines.
  final int? maxLines;

  @override
  State<TextFieldLy> createState() => _TextFieldLyState();
}

class _TextFieldLyState extends State<TextFieldLy> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Color mainColor = WidgetlyConfig().mainColor;

  @override
  void initState() {
    String locale = '';
    try {
      locale = Platform.localeName.substring(
        0,
        Platform.localeName.indexOf('_'),
      );
    } catch (e) {
      //
    }
    LocalizationLy.instance.setLocale(locale.isEmpty ? 'en' : locale);
    controller = TextEditingController(
      text: widget.initialValue == null ? null : '${widget.initialValue}',
    );
    if (widget.mainColor != null) {
      mainColor = widget.mainColor!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    (widget.textEditingController ?? controller)
        .selection = TextSelection.fromPosition(
      TextPosition(
        offset: (widget.textEditingController ?? controller).text.length,
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment:
          (widget.maxLines ?? 0) > 1
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
      children: [
        if (widget.label != null) buildLabel(),
        Expanded(
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width /
                (widget.label == null
                    ? 1
                    : kIsWeb == true
                    ? 3
                    : 1.9),
            height:
                widget.height ??
                ((widget.maxLines ?? 0) > 1
                    ? (40 * widget.maxLines!).toDouble()
                    : 55),
            child: Stack(
              children: [
                buildActionsWithTF(),
                if ((widget.textEditingController ?? controller)
                        .text
                        .isNotEmpty &&
                    widget.readOnly != true)
                  buildButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: EdgeInsets.only(top: (widget.maxLines ?? 0) > 1 ? 8 : 0),
      child: SizedBox(
        height: (widget.height ?? 55) - 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              (widget.maxLines ?? 0) > 1
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetectorLy(
                onTap: () {
                  if (widget.updateValue != null) {
                    widget.updateValue!('');
                  }
                  setState(() {
                    (widget.textEditingController ?? controller).text = '';
                  });
                },
                child: Icon(CupertinoIcons.xmark_circle, color: Colors.red),
              ),
            ),
            if (widget.obscureText != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetectorLy(
                  onTap: () {
                    widget.obscureTextFunction!();
                  },
                  child: Icon(
                    widget.obscureText == false
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    color: mainColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width:
            kIsWeb == true
                ? (MediaQuery.of(context).size.width * 2 / 3) / 3.5
                : MediaQuery.of(context).size.width / 3.8,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: TextLy(
            widget.descriptionLowercased == true
                ? widget.label!
                : widget.label!.toUpperCase(),
            color: ColorsLy.darkGrey,
            fontSize: 14,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  KeyboardActionsConfig buildKeyboardConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      nextFocus: false,
      actions:
          widget.readOnly != true && kIsWeb != true
              ? [
                KeyboardActionsItem(
                  focusNode: focusNode,
                  displayArrows: false,
                  toolbarButtons: [
                    (node) {
                      return GestureDetectorLy(
                        onTap: () {
                          node.unfocus();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextLy(
                            LocalizationLy.instance.translate('Close'),
                          ),
                        ),
                      );
                    },
                  ],
                ),
              ]
              : [],
    );
  }

  InputDecoration buildDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        left: 10,
        top: 8,
        right:
            10 +
            ((widget.textEditingController ?? controller).text.isNotEmpty &&
                    widget.readOnly != true
                ? 28
                : 0) +
            (widget.obscureText != null ? 36 : 0),
        bottom: 8,
      ),
      isDense: true,
      filled: true,
      hintText: widget.hintText,
      hintStyle: TextStyle(color: ColorsLy.darkGrey, fontSize: 20),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:
              widget.readOnly == true ? Colors.transparent : ColorsLy.darkGrey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildActionsWithTF() {
    return KeyboardActions(
      tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
      config: buildKeyboardConfig(),
      child: buildTextField(),
    );
  }

  Widget buildTextField() {
    return (widget.maxLines ?? 0) > 1
        ? TextField(
          readOnly: widget.readOnly ?? false,
          textCapitalization:
              widget.textCapitalization == true
                  ? TextCapitalization.characters
                  : TextCapitalization.none,
          maxLines: widget.maxLines,
          keyboardType: TextInputType.multiline,
          focusNode: focusNode,
          textInputAction: widget.textInputAction,
          enableSuggestions: false,
          autocorrect: false,
          controller: widget.textEditingController ?? controller,
          cursorColor: mainColor,
          onChanged: (String value) {
            setState(() {
              (widget.textEditingController ?? controller).text = value;
              (widget.textEditingController ?? controller)
                  .selection = TextSelection.fromPosition(
                TextPosition(offset: value.length),
              );
              if (widget.updateValue != null) {
                widget.updateValue!(value);
              }
            });
          },
          onSubmitted: (String value) {
            if (widget.submitAction != null) {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.submitAction!(value);
            }
          },
          style: TextStyle(
            fontSize: 24,
            color: widget.readOnly == true ? ColorsLy.darkGrey : Colors.black,
          ),
          textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.top,
          decoration: buildDecoration(),
        )
        : TextField(
          readOnly: widget.readOnly ?? false,
          textCapitalization:
              widget.textCapitalization == true
                  ? TextCapitalization.characters
                  : TextCapitalization.none,
          keyboardType: widget.keyboardType,
          focusNode: focusNode,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText == null ? false : widget.obscureText!,
          enableSuggestions: false,
          autocorrect: false,
          controller: widget.textEditingController ?? controller,
          cursorColor: mainColor,
          onChanged: (String value) {
            setState(() {
              (widget.textEditingController ?? controller).text = value;
              (widget.textEditingController ?? controller)
                  .selection = TextSelection.fromPosition(
                TextPosition(offset: value.length),
              );
              if (widget.updateValue != null) {
                widget.updateValue!(value);
              }
            });
          },
          onSubmitted: (String value) {
            if (widget.submitAction != null) {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.submitAction!(value);
            }
          },
          style: TextStyle(
            fontSize: 24,
            color: widget.readOnly == true ? ColorsLy.darkGrey : Colors.black,
          ),
          textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.top,
          decoration: buildDecoration(),
        );
  }
}
