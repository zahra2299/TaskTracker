import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/styles/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.white,
        secondary: primary,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.black,
        onBackground: Colors.grey,
        surface: Colors.blueGrey,
        onSurface: Colors.white),
    scaffoldBackgroundColor: mintGreen,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.arimo(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        color: primary,
      ),
      // bodyMedium: GoogleFonts.poppins(
      //   fontWeight: FontWeight.bold,
      //       //fontSize: 20,
      //   color: black,
      // ),
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.blue,
        onPrimary: Colors.white,
        secondary: Colors.green,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.black,
        onBackground: Colors.grey,
        surface: Colors.blueGrey,
        onSurface: Colors.white),
    scaffoldBackgroundColor: black,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.arimo(
        fontWeight: FontWeight.normal,
        fontSize: 20,
        color: primary,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: black,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey),
  );
}
