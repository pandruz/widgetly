import 'package:flutter/material.dart';

/// Configuration class for Widgetly package.
///
/// This singleton class stores global settings that can be accessed
/// throughout the package, such as main color, font family, and locale.
class WidgetlyConfig {
  /// Private constructor for singleton pattern
  WidgetlyConfig._();

  /// Singleton instance
  static final WidgetlyConfig _instance = WidgetlyConfig._();

  /// Factory constructor to return the singleton instance
  factory WidgetlyConfig() => _instance;

  /// The main color used throughout the components
  /// Defaults to blue
  Color _mainColor = Colors.blue;

  /// The font family used for text elements
  /// If null, the default system font will be used
  String? _fontFamily;

  /// The locale used for text formatting and translations
  /// If null, English locale will be used
  Locale _locale = const Locale('en');

  /// Get the current main color
  Color get mainColor => _mainColor;

  /// Get the current font family
  String? get fontFamily => _fontFamily;

  /// Get the current locale
  Locale? get locale => _locale;

  /// Initialize the Widgetly configuration with custom settings
  ///
  /// This method should be called before using any Widgetly components,
  /// typically in your app's main() method or in the initState() of your root widget.
  static void initialize({
    Color? mainColor,
    String? fontFamily,
    Locale? locale,
  }) {
    if (mainColor != null) _instance._mainColor = mainColor;
    if (fontFamily != null) _instance._fontFamily = fontFamily;
    if (locale != null) _instance._locale = locale;
  }

  /// Reset configuration to default values
  static void reset() {
    _instance._mainColor = Colors.blue;
    _instance._fontFamily = null;
    _instance._locale = Locale('en');
  }
}
