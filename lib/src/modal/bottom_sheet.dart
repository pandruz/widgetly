import 'package:widgetly/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomSheetLy extends StatelessWidget {
  BottomSheetLy({super.key, this.mainColor, required this.title, required this.child, this.cancelFunction});

  Color? mainColor;
  String? title;
  Widget child;
  Function()? cancelFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Container(
            decoration: BoxDecoration(
              color: mainColor ?? Colors.blue,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                        child: Text(
                          title!,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetectorLy(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (cancelFunction != null) {
                      cancelFunction!();
                    }
                  },
                  child: Padding(padding: const EdgeInsets.fromLTRB(60, 8, 10, 8), child: Icon(Icons.close, color: Colors.white, size: 22)),
                ),
              ],
            ),
          ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(title != null ? 0 : 10), topRight: Radius.circular(title != null ? 0 : 10)),
            ),
            child: Column(children: [Expanded(child: child)]),
          ),
        ),
      ],
    );
  }
}
