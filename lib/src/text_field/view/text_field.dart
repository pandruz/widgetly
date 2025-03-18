import 'dart:io';
import 'package:flutkit/src/extensions/colors_extensions.dart';
import 'package:flutkit/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutkit/src/localization/localization.dart';

class TextFieldKit extends StatefulWidget {
  const TextFieldKit({
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
  });

  final String? label;
  final String? hintText;
  final dynamic initialValue;
  final Function(String value)? updateValue;
  final Function()? obscureTextFunction;
  final Function(String value)? submitAction;
  final bool? descriptionLowercased;
  final bool? obscureText;
  final bool? readOnly;
  final bool? textCapitalization;
  final double? height;
  final Color? mainColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final TextAlignVertical? textAlignVertical;

  @override
  State<TextFieldKit> createState() => _TextFieldKitState();
}

class _TextFieldKitState extends State<TextFieldKit> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Color mainColor = Colors.blue;

  @override
  void initState() {
    LocalizationKit.instance.setLocale(Platform.localeName.isNotEmpty ? Platform.localeName.substring(0, Platform.localeName.indexOf('_')) : 'en');
    controller = TextEditingController(text: widget.initialValue == null ? null : '${widget.initialValue}');
    if (widget.mainColor != null) {
      mainColor = widget.mainColor!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    (widget.textEditingController ?? controller).selection = TextSelection.fromPosition(
      TextPosition(offset: (widget.textEditingController ?? controller).text.length),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
            height: widget.height ?? 55,
            child: Stack(
              children: [
                buildTextField(),
                if ((widget.textEditingController ?? controller).text.isNotEmpty && widget.readOnly != true) buildButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtons() {
    return SizedBox(
      height: (widget.height ?? 55) - 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetectorKit(
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
              child: GestureDetectorKit(
                onTap: () {
                  widget.obscureTextFunction!();
                },
                child: Icon(widget.obscureText == false ? CupertinoIcons.eye : CupertinoIcons.eye_slash, color: mainColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: kIsWeb == true ? (MediaQuery.of(context).size.width * 2 / 3) / 3.5 : MediaQuery.of(context).size.width / 3.8,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            widget.descriptionLowercased == true ? widget.label! : widget.label!.toUpperCase(),
            style: TextStyle(color: ColorsKit.darkGrey, fontSize: 14),
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
                      return GestureDetectorKit(
                        onTap: () {
                          node.unfocus();
                        },
                        child: Padding(padding: const EdgeInsets.all(10), child: Text(LocalizationKit.instance.translate('Close'))),
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
            ((widget.textEditingController ?? controller).text.isNotEmpty && widget.readOnly != true ? 28 : 0) +
            (widget.obscureText != null ? 36 : 0),
        bottom: 8,
      ),
      isDense: true,
      filled: true,
      hintText: widget.hintText,
      hintStyle: TextStyle(color: ColorsKit.darkGrey, fontSize: 20),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: mainColor, width: 2), borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.readOnly == true ? Colors.transparent : ColorsKit.darkGrey, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildTextField() {
    return KeyboardActions(
      tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
      config: buildKeyboardConfig(),
      child: TextField(
        readOnly: widget.readOnly ?? false,
        textCapitalization: widget.textCapitalization == true ? TextCapitalization.characters : TextCapitalization.none,
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
            (widget.textEditingController ?? controller).selection = TextSelection.fromPosition(TextPosition(offset: value.length));
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
        style: TextStyle(fontSize: 24, color: widget.readOnly == true ? ColorsKit.darkGrey : Colors.black),
        textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.top,
        decoration: buildDecoration(),
      ),
    );
  }
}
