import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.purpleAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purpleAccent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.purpleAccent,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}