import 'package:flutter/material.dart';

final primaryColor = Colors.indigoAccent.shade200;
final secondaryColor = Colors.indigo.shade500;

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    secondary: secondaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.indigo,
  brightness: Brightness.light,
  // primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  // textTheme: textTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // colorScheme: ColorScheme.fromSeed(
  //   primary: Color(0xFFB93C5D),
  //
  //   onPrimary: Colors.black,
  //   secondary: Colors.indigo.shade500,
  //   onSecondary: Color(0xFF322942),
  //   error: Colors.redAccent,
  //   onError: Colors.white,
  //   surface: Colors.indigoAccent.shade200,
  //   onSurface: Color(0xFF241E30),
  //   seedColor: primaryColor,
  //   brightness: Brightness.light,
  // ),
);

final textTheme = const TextTheme();
