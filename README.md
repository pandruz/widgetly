[![Pub Version](https://img.shields.io/pub/v/widgetly)](https://pub.dev/packages/widgetly)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter Platform](https://img.shields.io/badge/Platform-Flutter-02569B.svg)](https://flutter.dev)

# Widgetly

A collection of customizable Flutter widgets designed for rapid UI development. Widgetly provides ready-to-use components with consistent styling and behavior.

## Installation

To use this package, add `widgetly` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  widgetly: ^latest_version
```

## Configuration

Widgetly can be configured globally to maintain consistent styling across all components:

```dart
void main() {
  // Initialize Widgetly with your preferred configuration. If no configuration
  // is provided, the default values will be automatically used.
  WidgetlyConfig.initialize(
    mainColor: Colors.purple, // Default is Colors.blue
    fontFamily: 'Roboto', // If not specified, will use device's font
    locale: const Locale('it'), // Default is Locale('en')
  );

  runApp(MyApp());
}
```

Components will use these global settings by default, but you can always override them for individual instances:

```dart
ButtonLy(
  label: 'CUSTOM',
  mainColor: Colors.orange,  // This overrides the global mainColor
  buttonFunc: () => buttonFunc(),
)
```

## Components

### AppBarLy

A customizable app bar with built-in title, back navigation, and trailing widgets support.

```dart
AppBarLy(
  title: 'My App',
  mainColor: Colors.blue,
  backAction: () => Navigator.pop(context),
  trailingWidgets: [
    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
  ],
)
```

**Key Features:**

- Custom title text or widget
- Optional back button with action
- Support for trailing widgets
- Loading state handling
- Customizable colors

### ButtonLy

A versatile button component with support for outlined and filled styles, loading states, icons, and customizable colors.

```dart
ButtonLy(
  label: 'SUBMIT',
  mainColor: Colors.blue,
  textColor: Colors.white, // Custom text color
  buttonFunc: () => handleSubmit(),
  showOutline: true,
  isLoading: false,
  icon: Icons.send, // Optional icon
)
```

**Key Features:**

- Primary and outline styles
- Loading state with automatic spinner
- Uppercase text transformation
- Optional leading icon
- Custom text color support
- Consistent border radius and padding

### GestureDetectorLy

An enhanced gesture detector that provides haptic feedback and handles both tap and long press actions.

```dart
GestureDetectorLy(
  onTap: () => handleTap(),
  onLongPress: () => handleLongPress(),
  vibrate: true,
  child: Container(
    // Container
  ),
)
```

**Key Features:**

- Optional haptic feedback
- Support for both tap and long press
- Opaque hit testing behavior
- Simplified API over standard GestureDetector

### LabelledTextLy

A component for displaying label-value pairs with customizable styling and overflow handling.

```dart
LabelledTextLy(
  label: 'PRICE',
  value: '$49.99',
  valueColor: Colors.green,
  maxLines: 1,
)
```

**Key Features:**

- Support for label-value formatting
- Customizable colors and font sizes
- Text overflow handling
- Support for multi-line values
- Automatic uppercase labels

### PickerLy

A dropdown selector with built-in modal list view for selecting items from a collection.

```dart
PickerLy(
  label: 'COUNTRY',
  selectedValue: selectedCountry,
  values: countries,
  updateValue: (value) => setState(() => selectedCountry = value),
  deleteAction: () => setState(() => selectedCountry = null),
)
```

**Key Features:**

- Label and value display
- Modal item selection
- Optional delete button
- Customizable modal title
- Border styling and dropdown indicator

### PlaceholderLy

A component for displaying placeholder/empty state messages with optional icon and reset action.

```dart
PlaceholderLy(
  icon: Icons.search,
  placeholderText: 'No results found',
  resetAction: () => clearFilters(),
  resetButtonLabel: 'CLEAR FILTERS',
  mainColor: Colors.blue,
)
```

**Key Features:**

- Large icon display
- Customizable message text
- Optional reset button
- Flexible padding configuration
- Centralized layout

### StepperLy

A quantity selector with increment/decrement buttons and optional quantity limits.

```dart
StepperLy(
  mainColor: Colors.blue,
  quantity: 2,
  updateQuantity: (value) => setState(() => quantity = value),
  qtyLimit: 10,
  description: 'QUANTITY',
  outlined: true,
)
```

**Key Features:**

- Increment/decrement buttons
- Optional quantity limits
- Long press to min/max values
- Optional description label
- Outlined or filled button styles

### TextFieldLy

A customizable text input field with support for various input types, clear button, and optional label.

```dart
TextFieldLy(
  label: 'EMAIL',
  hintText: 'Enter your email',
  initialValue: email,
  updateValue: (value) => setState(() => email = value),
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  textEditingController: myController, // Optional controller
  obscureText: true, // For password fields
  obscureTextFunction: () => togglePasswordVisibility(), // Toggle password visibility
  readOnly: false,
  submitAction: (value) => submitForm(),
  textCapitalization: true,
  height: 60,
  textAlignVertical: TextAlignVertical.center,
)
```

**Key Features:**

- Optional label
- Clear button when text is present
- Password visibility toggle
- Custom keyboard types and actions
- Read-only mode
- Controller support
- Form submission handler
- Customizable height and text alignment
- Text capitalization options

### ToggleLy

A switch component with description text and customizable colors.

```dart
ToggleLy(
  description: 'DARK MODE',
  toggleValue: isDarkMode,
  updateFunc: (value) => setState(() => isDarkMode = value),
  mainColor: Colors.purple,
  readOnly: false,
)
```

**Key Features:**

- Description text with automatic uppercase
- Toggle state management
- Optional read-only mode
- Customizable colors
- Compact design with proper spacing

### RadioLy

A customizable radio button group widget with support for text or icon options.

```dart
RadioLy(
  buttons: ['Option 1', 'Option 2', 'Option 3'],
  selected: 0,
  update: (value) => setState(() => selectedOption = options[value]),
  mainColor: Colors.purple,
  buttonIcons: [Icons.home, Icons.favorite, Icons.settings], // Optional
)
```

**Key Features:**

- Horizontal radio button layout
- Support for both text and icon labels
- Single selection with clear visual feedback
- Customizable colors
- Automatic border radius handling for first/last items
- Consistent styling with the rest of the library

### CupertinoBoxLy

A stylized container widget that mimics iOS-style UI elements for consistent Cupertino design.

```dart
// For a single box
CupertinoBoxLy(
  isFirst: true,
  isLast: true,
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Single Item'),
  ),
)

// For a list of boxes
Column(
  children: [
    CupertinoBoxLy(
      isFirst: true,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('First Item'),
      ),
    ),
    CupertinoBoxLy(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Middle Item'),
      ),
    ),
    CupertinoBoxLy(
      isLast: true,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Last Item'),
      ),
    ),
  ],
)
```

**Key Features:**

- iOS-style container styling
- Proper border radius for items in a list (first and last items)
- Automatic borders between adjacent items
- Adaptive background color based on platform brightness
- Simplified creation of Cupertino-styled list groups
- Consistent with iOS design guidelines

### CupertinoExpandableBoxLy

A customizable expandable box widget with Cupertino styling.

```dart
CupertinoExpandableBoxLy(
  title: 'Expandable Box',
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Expandable Content'),
  ),
  onExpand: () => print('Expanded'),
  mainColor: Colors.blue,
)
```

**Key Features:**

- Collapsible container with a title bar
- Tap to expand or collapse the content
- Indicator icon changes based on the expanded state
- Customizable accent color
- Optional callback for expansion state changes
- Consistent Cupertino styling

## Utilities

Widgetly also includes several utility classes:

- **ColorsLy**: Provides color utilities and constants
- **LocalizationLy**: Simple localization support for internal strings
- **HexColor**: Extension for working with hex color values

## License

This package is available under the MIT License.
