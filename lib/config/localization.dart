import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Localization {
  final Locale locale;

  Localization(this.locale);

  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

 late Map<String, String> _localizationValues;

  Future<void> load() async {
    var jsonValues = await rootBundle
        .loadString("lib/resources/lang/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson =
    json.decode(jsonValues) as Map<String, dynamic>;

    _localizationValues = mappedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String? getTranslatedValue(String key) {
    return _localizationValues[key];
  }

  static const LocalizationsDelegate<Localization> delegate =
  _LocalizationDelegate();

  static List<Locale> supportedLocales = const [
    Locale('ru', 'RU'),
    Locale('en', 'US'),
    Locale('ar', 'AE'),
  ];
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'ru',
      'ar',
    ].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = Localization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant old) => false;
}
