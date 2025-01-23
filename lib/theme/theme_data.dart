import 'package:flutter/material.dart';

const Color battleshipGray = Color(0xFF828483);
const Color jet = Color(0xFF2A2924);
const Color white = Color(0xFFFCFBFA);
const Color alabaster = Color(0xFFE4E4DB);
const Color silver = Color(0xFFC4C4BE);
const Color red = Colors.red;
const Color green = Colors.green;

const ButtonStyle greenBtnStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(green),
  foregroundColor: WidgetStatePropertyAll(white),
);

final ThemeData customTheme = ThemeData(
  primaryColor: jet,
  primaryColorDark: battleshipGray,
  // accentColor: red,
  scaffoldBackgroundColor: jet,
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: alabaster),
  appBarTheme: const AppBarTheme(
    backgroundColor: jet,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: white,
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(white),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(white),
    ),
  ),
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: white,
        letterSpacing: 2,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: white,
        letterSpacing: 2,
      ),
      labelLarge: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.normal,
        color: white,
      ),
      labelSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: white,
      ),
      displayLarge: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      bodyLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: white,
      )),
  buttonTheme: const ButtonThemeData(
    buttonColor: white,
    textTheme: ButtonTextTheme.primary,
  ),

  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
      foregroundColor: WidgetStatePropertyAll(jet),
      backgroundColor: WidgetStatePropertyAll(white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: white,
        ),
      ),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    subtitleTextStyle: TextStyle(
      color: white,
    ),
  ),
  // Add more customizations as needed
  colorScheme: const ColorScheme(
    primary: jet,
    onPrimary: white,
    primaryContainer: battleshipGray,
    onPrimaryContainer: white,
    secondary: green,
    onSecondary: white,
    secondaryContainer: silver,
    onSecondaryContainer: jet,
    tertiary: red,
    onTertiary: white,
    tertiaryContainer: alabaster,
    onTertiaryContainer: jet,
    error: Colors.red,
    onError: white,
    surface: white,
    onSurface: jet,
    surfaceContainerHighest: silver,
    onSurfaceVariant: jet,
    outline: battleshipGray,
    inverseSurface: jet,
    onInverseSurface: white,
    shadow: Colors.black,
    brightness: Brightness.light,
  ),
);
