import 'package:flutkit/src/divider/view/divider.dart';
import 'package:flutkit/src/gesture_detector/view/gesture_detector.dart';
import 'package:flutkit/src/localization/localization.dart';
import 'package:flutkit/src/placeholder/view/placeholder.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemSelectorKit extends StatelessWidget {
  ItemSelectorKit({super.key, this.label, required this.selectedValue, required this.values, required this.updateValue});

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
    return Center(child: PlaceholderKit(icon: Icons.search_off, placeholderText: LocalizationKit.instance.translate('No element found')));
  }

  Widget buildElement(BuildContext context, dynamic element) {
    return GestureDetectorKit(
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
              if (values.last != element) Padding(padding: const EdgeInsets.only(top: 5), child: DividerKit(height: 1)),
            ],
          ),
        ),
      ),
    );
  }
}
