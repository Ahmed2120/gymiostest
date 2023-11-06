import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { english, arabic }

class LanguageProvider extends ChangeNotifier {
  final _localKey = "locale_language";
  Locale _locale = Locale(
    "en",
  );

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_localKey);
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
    Get.updateLocale(locale);
    notifyListeners();
  }

  void selectLanguage(Language language) async {
    final langaugeCode = language == Language.english ? "en" : "ar";
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localKey, langaugeCode);
    _locale = Locale(langaugeCode);

    Get.updateLocale(locale);
    notifyListeners();
  }

  Locale get locale => _locale;
  Language get selectedLanguage =>
      _locale.languageCode == "ar" ? Language.arabic : Language.english;
}
