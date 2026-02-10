import 'package:flutter/material.dart';
import 'package:widgetly/widgetly.dart';

// ignore: must_be_immutable
class BottomSheetLy extends StatelessWidget {
  BottomSheetLy({
    super.key,
    this.mainColor,
    required this.title,
    required this.child,
    this.cancelFunction,
  });

  Color? mainColor;
  String? title;
  Widget child;
  Function()? cancelFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Container(
            decoration: BoxDecoration(
              color: mainColor ?? WidgetlyConfig().mainColor,
              borderRadius: const .only(
                topLeft: .circular(10),
                topRight: .circular(10),
              ),
            ),
            child: Stack(
              alignment: .centerRight,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: .center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const .fromLTRB(10, 10, 30, 10),
                        child: TextLy(
                          title!,
                          fontWeight: .w600,
                          fontSize: 20,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: .ellipsis,
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
                  child: Padding(
                    padding: const .fromLTRB(60, 8, 10, 8),
                    child: Icon(Icons.close, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: .only(
                topLeft: .circular(title != null ? 0 : 10),
                topRight: .circular(title != null ? 0 : 10),
              ),
            ),
            child: Column(children: [Expanded(child: child)]),
          ),
        ),
      ],
    );
  }
}
