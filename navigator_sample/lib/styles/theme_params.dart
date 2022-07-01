import 'package:flutter/material.dart';

class ThemeParams {
  static Color white = const Color(0xFFE2E2E2);
  static Color grey = const Color(0xFF1E1E1E);
  static Color darkGrey = const Color(0xff121212);

  static ThemeData theme = ThemeData(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 40),
        headline2: TextStyle(fontSize: 30),
        headline3: TextStyle(fontSize: 14),
        bodyText1: TextStyle(fontSize: 16),
      ).apply(bodyColor: const Color(0xFFE2E2E2)),
      scaffoldBackgroundColor: darkGrey,
      cardColor: grey,
      dividerColor: white.withOpacity(0.2),
      appBarTheme: AppBarTheme(backgroundColor: darkGrey));
}
