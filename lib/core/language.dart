import 'package:amnak/export.dart';

bool isEn() => LocaleSettings.currentLocale == AppLocale.en;
Future<void> toggleLanguage() async {
  LocaleSettings.setLocale(isEn() ? AppLocale.ar : AppLocale.en);
  await sl<GetStorage>()
      .write(kLanguage, LocaleSettings.currentLocale.languageCode);
}

dynamic decideOnLanguage(dynamic en, dynamic ar) => isEn() ? en : ar;

void getInitialLanguage() {
  LocaleSettings.setLocaleRaw(
      sl<GetStorage>().read(kLanguage) ?? AppLocale.ar.languageCode);
}
