import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';
ThemeData themeEnglish = ThemeData(
  primaryColor: AppColor.primaryColor,
  inputDecorationTheme:InputDecorationTheme(
    focusColor: AppColor.primaryColor
  ),
  focusColor:AppColor.primaryColor,
  scaffoldBackgroundColor:AppColor.backgroundcolor,
  floatingActionButtonTheme:
  const FloatingActionButtonThemeData(backgroundColor: AppColor.primaryColor),
  appBarTheme:  AppBarTheme(
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: AppColor.primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.roboto().fontFamily, // Use Poppins
        fontSize: 25,
      ),
      backgroundColor: AppColor.thirdColor,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: AppColor.black,
      ),
      displayMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: AppColor.black,
      ),
      bodyLarge: GoogleFonts.montserrat(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      bodyMedium: GoogleFonts.poppins(
        height: 2,
        color: AppColor.grey,
        fontSize: 14,
      ),
    ),
    primarySwatch: Colors.blue,
  );

ThemeData themeArabic = ThemeData(
  appBarTheme:  AppBarTheme(
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.roboto().fontFamily, // Use Poppins
      fontSize: 25,
    ),
    backgroundColor: AppColor.thirdColor,
  ),
  primaryColor: AppColor.primaryColor,
  inputDecorationTheme:InputDecorationTheme(
      focusColor: AppColor.primaryColor
  ),
  focusColor:AppColor.primaryColor,
  fontFamily: GoogleFonts.cairo().fontFamily, // Use Cairo font
  textTheme: TextTheme(
    displayLarge: GoogleFonts.cairo(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: AppColor.black,
    ),
    displayMedium: GoogleFonts.cairo(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: AppColor.black,
    ),
    bodyLarge: GoogleFonts.cairo(
      height: 2,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: AppColor.black,
    ),
    bodyMedium: GoogleFonts.cairo(
      height: 2,
      fontSize: 14,
      color: AppColor.black,
    ),
  ),
  primarySwatch: Colors.green,
);
