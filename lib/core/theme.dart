import 'package:amnak/core/text_theme.dart';
import 'package:amnak/export.dart';
import 'package:amnak/main.dart';
import 'package:google_fonts/google_fonts.dart';

const kRoundedAll = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(33.0),
  ),
);

final OutlineInputBorder kBorder = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Colors.transparent,
  ),
  borderRadius: BorderRadius.circular(16),
);

final lightTheme = ThemeData(
  primaryColor: kPrimaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: kLight,
  textTheme: lightTextTheme,
  fontFamily: GoogleFonts.almarai().fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor: kLight,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll<Color>(kLight),
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      side: const WidgetStatePropertyAll<BorderSide>(
        BorderSide(color: kDarkBlue),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: kTextGreyColor,
          fontSize: 19,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  primaryColor: kPrimaryColor,
  brightness: Brightness.dark,
  textTheme: darkTextTheme,
  fontFamily: GoogleFonts.almarai().fontFamily,
  scaffoldBackgroundColor: kDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: kDark,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll<Color>(kDark),
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      side: const WidgetStatePropertyAll<BorderSide>(
        BorderSide(color: kPurple),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: kWhite,
          fontSize: 19,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  ),
);

bool isDark({BuildContext? context}) => false;
Future<void> toggleTheme() async {
  // MyApp.isDark.value = !MyApp.isDark.value;
  await sl<GetStorage>().write(kTheme, false);
}

dynamic decideOnTheme(dynamic light, dynamic dark, {BuildContext? context}) =>
    isDark(context: context) ? dark : light;
