import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    primaryColor: ColorSys.kprimary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorSys.kbackgroundColor,
      selectedItemColor: ColorSys.kprimary,
      unselectedItemColor: ColorSys.kUnselectedBottomBarIconColor,
    ),
    scaffoldBackgroundColor: ColorSys.kbackgroundColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: ColorSys.kprimary,
        fontSize: 18,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: ColorSys.kbackgroundColor,
      iconTheme: IconThemeData(color: ColorSys.kprimary),
      actionsIconTheme: IconThemeData(color: ColorSys.kprimary),
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ColorSys.kprimary,
        fontSize: 38,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: ColorSys.kprimary,
        fontSize: 18,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: ColorSys.kprimary,
        fontSize: 15,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
