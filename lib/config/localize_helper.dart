import 'package:core/common/app_preferences.dart';
import 'package:core/common/global_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:surf_practice_chat_flutter/config/language_config.dart';
import 'package:surf_practice_chat_flutter/config/localization.dart';

class LocalizeHelper extends ChangeNotifier {
  Locale locale;

  LocalizeHelper(this.locale);

  final localizationsDelegates = [
    Localization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];

  static List<Language> languages() {
    return [
      Language(1, "Русский", "🇷🇺", "ru", "RU"),
      Language(2, "English", "🇺🇸", "en", "US"),
    ];
  }

  Future<bool> setLocale(Locale locale) async {
    this.locale = locale;
    await SharedPrefManager.writeString(
      GlobalConstants.localeKey,
      locale.languageCode,
    );
    return true;
  }

  Future<void> updateLocale() async {
    var languageCode = SharedPrefManager.getString(GlobalConstants.localeKey);
    if (languageCode != null && languageCode.isNotEmpty) {
      for (var lang in languages()) {
        if (lang.languageCode == languageCode) {
          locale = Locale(lang.languageCode, lang.countryCode);
        }
      }
    } else {
      locale = const Locale("ru", "RU");
    }
    notifyListeners();
  }
}
