import 'package:flutter/material.dart';

class UpApiTheme {
  static ThemeData myTheme = ThemeData(

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        ),
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 52)),
        backgroundColor: WidgetStatePropertyAll(Colors.orange),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Imposta il border-radius a 5px
        ),
      ),
    ),

    colorScheme: ColorScheme(
      onPrimary: Colors.orange,
      onSecondary: Colors.blue,
      primary: Colors.orange,
      secondary: Colors.blue,
      brightness: Brightness.light,
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Color.fromRGBO(214, 214, 214, 1),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Color.fromRGBO(214, 214, 214, 1),
          width: 1,
        ),
      ),
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700), // Stile per i titoli principali
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), // Variante più piccola
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Testo normale
      bodyMedium: TextStyle(fontSize: 15),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),


    ),

  );
}
