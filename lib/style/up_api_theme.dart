import 'package:flutter/material.dart';

class UpApiTheme {
  static ThemeData myTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 52)),
        backgroundColor: const WidgetStatePropertyAll(Colors.orange),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ), // Imposta il border-radius a 5px
        ),
      ),
    ),

    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        minimumSize: WidgetStatePropertyAll(Size.zero),
        //tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //foregroundColor: WidgetStatePropertyAll(Colors.blue),
        //splashFactory: NoSplash.splashFactory,
        //overlayColor: WidgetStatePropertyAll(Colors.transparent),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ),


    colorScheme: const ColorScheme(
      onPrimary: Colors.black,
      onSecondary: Colors.blue,
      primary: Colors.black,
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
        borderSide: const BorderSide(
          color: Color.fromRGBO(214, 214, 214, 1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromRGBO(214, 214, 214, 1),
        ),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ), // Stile per i titoli principali
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ), // Variante più piccola
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ), // Testo normale
      bodyMedium: TextStyle(fontSize: 15),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
  );
}
