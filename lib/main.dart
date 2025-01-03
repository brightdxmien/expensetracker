import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 206, 174, 162));

var kDarkTheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 64, 33, 22));
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkTheme.primaryContainer,
                foregroundColor: Colors.white,
                textStyle: TextStyle(color: Colors.white)))),
    theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryFixedVariant,
            foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.onPrimaryContainer,
                textStyle: TextStyle(color: Colors.white)))),
    home: Expenses(),
  ));
}
