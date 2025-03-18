import 'package:flutkit/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutter/material.dart';

class ButtonKit extends StatelessWidget {
  const ButtonKit({super.key, required this.label, required this.mainColor, this.buttonFunc, this.showOutline, this.isLoading});

  final String label;
  final Color mainColor;
  final Function()? buttonFunc;
  final bool? showOutline;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetectorKit(
      onTap: () {
        if (buttonFunc != null) {
          buttonFunc!();
        }
      },
      child: Container(
        height: 45,
        decoration: buildDecoration(),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Center(child: isLoading == true ? buildLoading() : buildButton())),
      ),
    );
  }

  Widget buildButton() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          buttonFunc != null ? label.toUpperCase() : label,
          style: TextStyle(
            color:
                showOutline == true
                    ? mainColor
                    : mainColor == Colors.white
                    ? Colors.black
                    : Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return SizedBox(height: 25, width: 25, child: CircularProgressIndicator(color: mainColor == Colors.white ? Colors.black : Colors.white));
  }

  BoxDecoration buildDecoration() {
    return BoxDecoration(
      color: showOutline == true ? Colors.white : mainColor,
      border: Border.all(
        strokeAlign: BorderSide.strokeAlignOutside,
        width: 2.5,
        color:
            mainColor == Colors.black && showOutline != true
                ? Colors.white
                : showOutline == true
                ? mainColor
                : Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
