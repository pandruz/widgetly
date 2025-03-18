import 'package:widgetly/src/extensions/colors_extensions.dart';
import 'package:flutter/material.dart';

class ToggleLy extends StatefulWidget {
  const ToggleLy({super.key, required this.description, required this.updateFunc, required this.toggleValue, this.readOnly, this.mainColor});

  final String description;
  final Function(bool value) updateFunc;
  final bool toggleValue;
  final bool? readOnly;
  final Color? mainColor;

  @override
  State<ToggleLy> createState() => _RPToggleState();
}

class _RPToggleState extends State<ToggleLy> {
  bool value = false;
  Color color = Colors.blue;

  @override
  void initState() {
    value = widget.toggleValue;
    if (widget.mainColor != null) {
      color = widget.mainColor!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [buildDescription(), buildSwitch(context, color)]),
    );
  }

  Widget buildDescription() {
    return Expanded(child: Text(widget.description.toUpperCase(), maxLines: 2, style: TextStyle(fontSize: 14)));
  }

  Widget buildSwitch(BuildContext context, Color color) {
    return IgnorePointer(
      ignoring: widget.readOnly ?? false,
      child: Switch(
        activeColor: color.withValues(alpha: widget.readOnly == true ? 0.5 : 1.0),
        activeTrackColor: color.withValues(alpha: widget.readOnly == true ? 0.2 : 0.5),
        inactiveThumbColor: ColorsLy.darkGrey,
        inactiveTrackColor: ColorsLy.darkGrey.withValues(alpha: 0.5),
        trackOutlineColor: WidgetStateColor.resolveWith((states) {
          return Colors.transparent;
        }),
        splashRadius: 50.0,
        value: value,
        onChanged: (newValue) {
          widget.updateFunc(newValue);
          setState(() {
            value = newValue;
          });
        },
      ),
    );
  }
}
