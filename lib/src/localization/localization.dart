class LocalizationLy {
  static LocalizationLy? _instance;

  static LocalizationLy get instance {
    _instance ??= LocalizationLy();
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
