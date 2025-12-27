import 'package:flutter/material.dart';

var _inputDecorationThemes = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  contentPadding: EdgeInsets.symmetric(
    horizontal: 30,
    vertical: 15
  ),
);

const _useMaterial3 = true;
const _primaryColor = Colors.deepPurple;

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
  ),
  useMaterial3: _useMaterial3,
  inputDecorationTheme: _inputDecorationThemes,
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.dark,
  ),
  useMaterial3: _useMaterial3,
  inputDecorationTheme: _inputDecorationThemes,
);