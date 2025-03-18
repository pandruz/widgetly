import 'package:widgetly/src/divider/view/divider.dart';
import 'package:widgetly/src/gesture_detector/view/gesture_detector.dart';
import 'package:widgetly/src/localization/localization.dart';
import 'package:widgetly/src/placeholder/view/placeholder.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemSelectorLy extends StatelessWidget {
  ItemSelectorLy({super.key, this.label, required this.selectedValue, required this.values, required this.updateValue});

  final String? label;
  final Iterable<dynamic> values;
  final Function(dynamic element) updateValue;

  dynamic selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child:
          values.isEmpty
              ? buildNoElements()
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [for (var element in values) buildElement(context, element)],
                  ),
                ),
              ),
    );
  }

  Widget buildNoElements() {
    return Center(child: PlaceholderLy(icon: Icons.search_off, placeholderText: LocalizationLy.instance.translate('No element found')));
  }

  Widget buildElement(BuildContext context, dynamic element) {
    return GestureDetectorLy(
      onTap: () {
        if (element != null) {
          selectedValue = element!;
          updateValue(element);
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(element == null ? '-' : '$element', style: TextStyle(fontSize: 20, color: Colors.black)),
              if (values.last != element) Padding(padding: const EdgeInsets.only(top: 5), child: DividerLy(height: 1)),
            ],
          ),
        ),
      ),
    );
  }
}
