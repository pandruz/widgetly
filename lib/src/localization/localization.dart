class LocalizationKit {
  static LocalizationKit? _instance;

  static LocalizationKit get instance {
    _instance ??= LocalizationKit();
    return _instance!;
  }

  final Map<String, Map<String, String>> _translations = {
    'en': {'Close': 'Close', 'No element found': 'No element found', 'Reset': 'Reset'},
    'it': {'Close': 'Chiudi', 'No element found': 'Nessun elemento trovato', 'Reset': 'Reset'},
  };

  String _currentLocale = 'en';

  void setLocale(String locale) {
    if (_translations.containsKey(locale)) {
      _currentLocale = locale;
    }
  }

  String translate(String key) {
    return _translations[_currentLocale]?[key] ?? key;
  }
}
