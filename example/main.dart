import 'package:flutter/material.dart';
import 'package:widgetly/widgetly.dart';

void main() {
  // Initialize Widgetly with global settings
  WidgetlyConfig.initialize(
    mainColor: Colors.purple,
    locale: const Locale('it'),
  );
  runApp(const WidgetlyExampleApp());
}

class WidgetlyExampleApp extends StatelessWidget {
  const WidgetlyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgetly Examples',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        fontFamily: WidgetlyConfig().fontFamily,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables for the different components
  String _textFieldValue = '';
  bool _toggleValue = false;
  int _stepperValue = 1;
  String? _selectedItem;
  bool _isLoading = false;
  String _selectedOption = 'Option 1';

  // Sample data for picker
  final List<String> _items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
  ];
  // Sample options for RadioLy
  final List<String> _radioOptions = ['Option 1', 'Option 2', 'Option 3'];

  @override
  void initState() {
    super.initState();
    _selectedItem = _items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarLy example
      appBar: AppBarLy(
        title: 'All Widgetly Components',
        mainColor: WidgetlyConfig().mainColor,
        backAction: () => Navigator.pop(context),
        trailingWidgets: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About Widgetly'),
                  content: const Text(
                    'This screen demonstrates all Widgetly components in a single view.',
                  ),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // Main body with all components
      body: SingleChildScrollView(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // Section header
            const LabelledTextLy(
              label: 'TEXT FIELD',
              value: 'Input with label and custom styling',
            ),
            const SizedBox(height: 8),

            // TextFieldLy example
            TextFieldLy(
              label: 'USERNAME',
              hintText: 'Enter your username',
              initialValue: _textFieldValue,
              updateValue: (value) => setState(() => _textFieldValue = value),
              mainColor: WidgetlyConfig().mainColor,
            ),
            const SizedBox(height: 24),

            // ToggleLy example
            ToggleLy(
              description: 'ENABLE NOTIFICATIONS',
              toggleValue: _toggleValue,
              updateFunc: (value) => setState(() => _toggleValue = value),
              mainColor: WidgetlyConfig().mainColor,
            ),
            const SizedBox(height: 24),

            // StepperLy example
            StepperLy(
              mainColor: WidgetlyConfig().mainColor,
              quantity: _stepperValue,
              updateQuantity: (value) =>
                  setState(() => _stepperValue = value.toInt()),
              qtyLimit: 10,
              description: 'QUANTITY',
            ),
            const SizedBox(height: 24),

            // PickerLy example
            PickerLy(
              label: 'SELECT FRUIT',
              selectedValue: _selectedItem,
              values: _items,
              updateValue: (value) =>
                  setState(() => _selectedItem = value as String),
              mainColor: WidgetlyConfig().mainColor,
              deleteAction: () => setState(() => _selectedItem = null),
            ),
            const SizedBox(height: 24),

            // ButtonLy examples
            Row(
              children: [
                Expanded(
                  child: ButtonLy(
                    label: 'FILLED',
                    mainColor: WidgetlyConfig().mainColor,
                    buttonFunc: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ButtonLy(
                    label: 'OUTLINED',
                    mainColor: WidgetlyConfig().mainColor,
                    showOutline: true,
                    buttonFunc: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ButtonLy with loading state
            ButtonLy(
              label: 'LOAD DATA',
              mainColor: Colors.blue,
              isLoading: _isLoading,
              icon: Icons.download,
              buttonFunc: () {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) setState(() => _isLoading = false);
                });
              },
            ),
            const SizedBox(height: 24),

            // PlaceholderLy example
            const PlaceholderLy(
              icon: Icons.image_not_supported,
              placeholderText: 'No images found in this gallery',
              resetButtonLabel: 'BROWSE IMAGES',
            ),
            const SizedBox(height: 16),

            // LabelledTextLy example with multiple lines
            const LabelledTextLy(
              label: 'DESCRIPTION',
              value:
                  'This is a showcase of all the components available in the Widgetly package. Each component is designed to be customizable and easy to use.',
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // RadioLy example
            Column(
              crossAxisAlignment: .start,
              children: [
                TextLy(
                  'SELECTED OPTION: $_selectedOption',
                  fontSize: 14,
                  fontWeight: .bold,
                ),
                const SizedBox(height: 8),
                ...List.generate(_radioOptions.length, (index) {
                  return Padding(
                    padding: const .only(bottom: 8.0),
                    child: RadioLy(
                      buttons: _radioOptions,
                      selected: index,
                      update: (value) => setState(
                        () => _selectedOption = _radioOptions[value],
                      ),
                      mainColor: WidgetlyConfig().mainColor,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 24),

            // CupertinoBoxLy example
            const TextLy('CUPERTINO BOX', fontSize: 14, fontWeight: .bold),
            const SizedBox(height: 8),
            Column(
              children: [
                CupertinoBoxLy(
                  isFirst: true,
                  child: const Padding(
                    padding: .all(16.0),
                    child: TextLy('First Item in List', fontSize: 16),
                  ),
                ),
                CupertinoBoxLy(
                  child: const Padding(
                    padding: .all(16.0),
                    child: TextLy('Middle Item in List', fontSize: 16),
                  ),
                ),
                CupertinoBoxLy(
                  isLast: true,
                  child: const Padding(
                    padding: .all(16.0),
                    child: TextLy('Last Item in List', fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // CupertinoExpandableBoxLy example
            const TextLy(
              'CUPERTINO EXPANDABLE BOX',
              fontSize: 14,
              fontWeight: .bold,
            ),
            const SizedBox(height: 8),
            CupertinoExpandableBoxLy(
              title: 'Tap to Expand/Collapse',
              child: Padding(
                padding: const .all(16.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    TextLy('This is expandable content', fontSize: 16),
                    const SizedBox(height: 8),
                    TextLy(
                      'You can add any widgets here that will be shown or hidden when the user taps the header.',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Example of multiple expandable boxes in a group
            const TextLy(
              'GROUPED EXPANDABLE BOXES',
              fontSize: 14,
              fontWeight: .bold,
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                CupertinoExpandableBoxLy(
                  title: 'Section 1',
                  child: const Padding(
                    padding: .all(16.0),
                    child: TextLy('Content for Section 1', fontSize: 16),
                  ),
                ),
                CupertinoExpandableBoxLy(
                  title: 'Section 2',
                  child: const Padding(
                    padding: .all(16.0),
                    child: TextLy('Content for Section 2', fontSize: 16),
                  ),
                ),
                CupertinoExpandableBoxLy(
                  title: 'Section 3',
                  child: const Padding(
                    padding: .all(16.0),
                    child: TextLy('Content for Section 3', fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
