import 'package:flutter/material.dart';
import 'colors_manager.dart';
class AppThemeManager {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: "DM_Sans",
      primaryColor: ColorsManager.primary,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
