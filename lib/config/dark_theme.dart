import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '/config/pallete.dart';
import 'constants.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Palette.kToColor,
  brightness: Brightness.dark,
  primaryColor: kDarkPrimary,
  scaffoldBackgroundColor: kDarkBackground,
  disabledColor: const Color(0xFF292E32),
  primaryColorDark: kDarkStrokeColor,
  shadowColor: kDarkStrokeColor,
  primaryColorLight: kDarkFillColor,
  //bottomAppBarColor: kDarkFillColor,
  dividerColor: kDarkDividerColor,
  iconTheme: const IconThemeData(color: kDarkHintTextColor),
  appBarTheme: AppBarTheme(
    ///centerTitle: true,
    titleTextStyle: GoogleFonts.dmSans(
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    backgroundColor: kDarkBackground,
    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.dmSans(
      fontWeight: FontWeight.w400,
      color: kDarkHintTextColor,
    ),
    filled: true,
    fillColor: kDarkFillColor,
    focusColor: const Color(0xFF235784),
    border: kDarkInputBorder,
    enabledBorder: kDarkInputBorder,
    focusedBorder: kDarkInputFocusBorder,
    contentPadding: REdgeInsets.all(14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(5),
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 54.h)),
      shape: MaterialStateProperty.all(const StadiumBorder()),
      foregroundColor: MaterialStateProperty.all(elevatedButtonTextColor),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.dmSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: elevatedButtonTextColor,
        ),
      ),
    ),
  ),
  cardColor: const Color(0xFF212330),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.dmSans(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    headlineMedium: GoogleFonts.dmSans(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    headlineSmall: GoogleFonts.dmSans(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    displayLarge: GoogleFonts.dmSans(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    displayMedium: GoogleFonts.dmSans(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    displaySmall: GoogleFonts.dmSans(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    titleLarge: GoogleFonts.dmSans(
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFFFF),
    ),
    titleMedium: GoogleFonts.dmSans(
      fontWeight: FontWeight.w500,
      color: const Color(0xFF01B4D4),
    ),
    bodyLarge: GoogleFonts.dmSans(
      fontWeight: FontWeight.w400,
      color: kDarkTextColor,
    ),
    bodyMedium: GoogleFonts.dmSans(
      fontWeight: FontWeight.w400,
      color: kDarkTextColor,
    ),
  ), //bottomAppBarTheme: BottomAppBarTheme(color: kDarkFillColor),
);
