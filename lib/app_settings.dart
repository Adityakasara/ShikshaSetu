import 'package:flutter/material.dart';

class AppSettings {
  static ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  static ValueNotifier<bool> isHindi = ValueNotifier(false);

  static ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  static String text(String en, String hi) {
    return isHindi.value ? hi : en;
  }
}

