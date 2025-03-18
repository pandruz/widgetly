import 'package:flutkit/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutkit/src/extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';

class AppBarKit extends StatelessWidget implements PreferredSizeWidget {
  const AppBarKit({
    super.key,
    this.title,
    this.titleWidget,
    this.mainColor,
    this.backAction,
    this.leadingWidget,
    this.isLoading,
    this.trailingWidgets,
  });

  final String? title;
  final Widget? titleWidget;
  final Color? mainColor;
  final Function()? backAction;
  final Widget? leadingWidget;
  final bool? isLoading;
  final List<Widget>? trailingWidgets;

  @override
  Widget build(BuildContext context) {
    Color color = mainColor ?? Colors.blue;
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: AppBar(
        title: buildTitle(color),
        centerTitle: true,
        backgroundColor: color,
        leading: buildLeading(context, color),
        actions: buildActions(context),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget buildTitle(Color color) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: titleWidget ?? Text(title ?? '', style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 22)),
    );
  }

  Widget buildLeading(BuildContext context, Color color) {
    return leadingWidget != null
        ? leadingWidget!
        : backAction == null
        ? SizedBox(height: MediaQuery.of(context).size.width * 0.06, width: MediaQuery.of(context).size.height * 0.06)
        : GestureDetectorKit(
          onTap: () {
            if ((isLoading ?? false) == false) {
              FocusManager.instance.primaryFocus?.unfocus();
              backAction!();
            }
          },
          child: Opacity(opacity: (isLoading ?? false) == false ? 1 : 0.3, child: Center(child: Icon(Icons.arrow_back, color: color))),
        );
  }

  List<Widget> buildActions(BuildContext context) {
    return trailingWidgets.isNullOrEmpty
        ? [SizedBox(height: MediaQuery.of(context).size.width * 0.06, width: MediaQuery.of(context).size.height * 0.06)]
        : trailingWidgets!;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
