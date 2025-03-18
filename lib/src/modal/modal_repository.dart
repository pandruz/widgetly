import 'package:widgetly/src/modal/bottom_sheet.dart';
import 'package:flutter/material.dart';

class ModalRepository {
  ModalRepository._privateConstructor();
  static final ModalRepository shared = ModalRepository._privateConstructor();

  void showBottomSheet({
    required BuildContext context,
    required Widget bottomSheet,
    Color? mainColor,
    String? title,
    bool? isBig,
    Function()? cancelFunction,
  }) {
    try {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * (isBig == true ? 0.9 : 0.7),
            child: BottomSheetLy(mainColor: mainColor, title: title, cancelFunction: cancelFunction, child: bottomSheet),
          );
        },
      );
    } catch (e) {
      //
    }
  }
}
