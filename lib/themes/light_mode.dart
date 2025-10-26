import 'package:flutter/material.dart';

// Light Mode Theme
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF9E4581), // Purple
    secondary: Color(0xFFFF4892), // Pink
    //tertiary: ,     // Beige
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFE8D4B7), // Beige background
  ),
);

// Dark Mode Theme
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xff83005a), // Beige
    secondary: Color(0xFF780032), // Pink
    tertiary: Color(0xFFFF0045), // Purple
    surface: Color(0xFF2D2D2D),

    background: Color(0xFF1A1A1A), // Dark background
  ),
);

// Usage in main.dart:
// void main() {
//   runApp(MaterialApp(
//     theme: AppTheme.lightTheme,
//     darkTheme: AppTheme.darkTheme,
//     themeMode: ThemeMode.system, // or ThemeMode.light / ThemeMode.dark
//     home: YourHomePage(),
//   ));
// }
