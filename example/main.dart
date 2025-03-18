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

  // Sample data for picker
  final List<String> _items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
  ];

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
                builder:
                    (context) => AlertDialog(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              updateQuantity: (value) => setState(() => _stepperValue = value),
              qtyLimit: 10,
              description: 'QUANTITY',
            ),
            const SizedBox(height: 24),

            // PickerLy example
            PickerLy(
              label: 'SELECT FRUIT',
              selectedValue: _selectedItem,
              values: _items,
              updateValue:
                  (value) => setState(() => _selectedItem = value as String),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
