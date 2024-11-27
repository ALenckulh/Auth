import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomThemes {
  static const textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  final defaultTheme = ThemeData(
    fontFamily: 'Montserrat',
    primaryColor: MyColors.primary550,
    primaryTextTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      //labelSmall usado no botão
      labelSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
    ),
    //

    //
    colorScheme: const ColorScheme(
      primary: MyColors.primary500,
      secondary: MyColors.secondary200,
      surface: MyColors.white0,
      error: MyColors.red200,
      onPrimary: MyColors.primary100,
      onSecondary: MyColors.white10,
      onSurface: MyColors.primary550,
      onError: MyColors.primary100,
      brightness: Brightness.dark,
    ),
    //
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: MyColors.secondary200,
      contentTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.primary100,
      ),
    ),
    //
    datePickerTheme: const DatePickerThemeData(
      elevation: 0,
      locale: Locale('pt', 'PT'),
      headerHeadlineStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: MyColors.primary550,
      ),
      headerBackgroundColor: MyColors.primary100,
      weekdayStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.primary400,
      ),
      dayStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: MyColors.primary400,
      ),
      dividerColor: MyColors.primary300,
      cancelButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: MyColors.primary550,
            fontFamily: 'Montserrat',
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(MyColors.red200),
      ),
      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: MyColors.primary550,
            fontFamily: 'Montserrat',
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(MyColors.primary550),
      ),
    ),
    //
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 28,
      backgroundColor: MyColors.primary550,
      foregroundColor: MyColors.primary100,
      splashColor: MyColors.white100.withOpacity(0.1),
      focusColor: MyColors.white100.withOpacity(0.1),
      hoverColor: MyColors.primary600,
    ),
    //
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconSize: WidgetStatePropertyAll(28),
      ),
    ),
    //
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MyColors.primary300,
      filled: true,
      prefixIconColor: MyColors.primary400,
      labelStyle: const TextStyle(
        color: MyColors.primary400,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      suffixIconColor: MyColors.primary400,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MyColors.primary550),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MyColors.primary550, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    ),
    //
    chipTheme: ChipThemeData(
      backgroundColor: MyColors.primary300,
      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      side: const BorderSide(
        color: Colors.transparent,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      labelStyle: const TextStyle(
        color: MyColors.secondary200,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
    ),
    //
    scaffoldBackgroundColor: MyColors.white0,
  );
}
