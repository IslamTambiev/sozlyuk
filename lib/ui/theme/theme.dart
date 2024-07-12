import 'package:flutter/material.dart';

final primaryColor = Colors.indigoAccent.shade200;
final secondaryColor = Colors.indigo.shade500;

final darkTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.indigo,
  brightness: Brightness.dark,
  // primaryColor: primaryColor,
  // textTheme: _textTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: primaryColor,
  //   secondary: secondaryColor,
  //   brightness: Brightness.dark,
  // ),
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
  //   seedColor: primaryColor,
  //   brightness: Brightness.light,
  // ),
);

const _textTheme = TextTheme();
