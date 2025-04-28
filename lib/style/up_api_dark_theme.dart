import 'package:flutter/material.dart';
import 'package:up_api/style/colors/up_api_colors_dark.dart';

class UpApiDarkTheme {
  static ThemeData myTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 52)),
        backgroundColor: const WidgetStatePropertyAll(UpApiColorsDark.primaryBrand),
        foregroundColor: const WidgetStatePropertyAll(UpApiColorsDark.secondaryText),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Imposta il border-radius a 5px
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: UpApiColorsDark.primaryBrand, // colore testo & icone
        side: const BorderSide(color: UpApiColorsDark.primaryBrand), // bordo
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),


    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      color: UpApiColorsDark.secondaryBackground,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        minimumSize: WidgetStatePropertyAll(Size.zero),
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 15, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
        ),
      ),
    ),

    colorScheme: const ColorScheme(
      onPrimary: UpApiColorsDark.primaryBrand,
      onSecondary: UpApiColorsDark.primaryText,
      primary: UpApiColorsDark.primaryText,
      secondary: UpApiColorsDark.secondaryBrand,
      brightness: Brightness.light,
      error: UpApiColorsDark.error,
      onError: UpApiColorsDark.onError,
      surfaceContainer: UpApiColorsDark.primaryBackground,
      surface: UpApiColorsDark.primaryBackground,
      onSurface: UpApiColorsDark.primaryText,
    ),



    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color.fromRGBO(214, 214, 214, 1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color.fromRGBO(214, 214, 214, 1)),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700), // Stile per i titoli principali
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), // Variante più piccola
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Testo normale
      bodyMedium: TextStyle(fontSize: 15),
      labelMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
  );
}
