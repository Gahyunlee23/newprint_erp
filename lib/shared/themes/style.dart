import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {

  static const Color primaryColor = Color(0xFF1176C0);
  static const Color onPrimary = Colors.white;
  static const Color primaryContainer = Color(0xFFD1E4FF);
  static const Color onPrimaryContainer = Color(0xFF001D35);
  static const Color primaryFixed = Color(0xFFD1E4FF);
  static const Color primaryFixedDim = Color(0xFF9FCAFD);
  static const Color onPrimaryFixed = Color(0xFF001D35);
  static const Color onPrimaryFixedVariant = Color(0xFF184974);

  static const Color secondaryColor = Color(0xFF535F70);
  static const Color onSecondary = Colors.white;
  static const Color secondaryContainer = Color(0xFFD6E4F7);
  static const Color onSecondaryContainer = Color(0xFF0F1C2B);
  static const Color secondaryFixed = Color(0xFFD6E4F7);
  static const Color secondaryFixedDim = Color(0xFFBAC8DB);
  static const Color onSecondaryFixed = Color(0xFF0F1C2B);
  static const Color onSecondaryFixedVariant = Color(0xFF3B4858);

  static const Color errorColor = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color surfaceDim = Color(0xFFD8DAE0);
  static const Color surface = Color(0xFFF8F9FF);
  static const Color surfaceBright = Color(0xFFF8F9FF);

  static const Color surfContainerLowest = Colors.white;
  static const Color surfContainerLow = Color(0xFFF2F3F9);
  static const Color surfContainer = Color(0xFFECEEF4);
  static const Color surfContainerHigh = Color(0xFFE6E8EE);
  static const Color surfContainerHighest = Color(0xFFE1E2E8);

  static const Color onSurface = Color(0xFF191C20);
  static const Color onSurfVar  = Color(0xFF42474E);
  static const Color outline = Color(0xFF73777F);
  static const Color outlineVariant = Color(0xFFC3C7CF);

  static const Color inverseSurface = Color(0xFFEFF0F7);
  static const Color inverseOnSurface  = Color(0xFF2E3135);
  static const Color inversePrimary = Color(0xFF2E3135);

  static const Color scrim = Colors.black;
  static const Color shadow = Colors.black;

  static const Color primaryDark = Color(0xFF9FCAFD);
  static const Color onPrimaryDark =  Color(0xFF003257);
  static const Color primaryContainerDark = Color(0xFF184974);
  static const Color onPrimaryContainerDark = Color(0xFFD1E4FF);
  static const Color primaryFixedDark = Color(0xFFD1E4FF);
  static const Color primaryFixedDimDark = Color(0xFF9FCAFD);
  static const Color onPrimaryFixedDark = Color(0xFF001D35);
  static const Color onPrimaryFixedVariantDark = Color(0xFF184974);

  static const Color secondaryDark = Color(0xFFBAC8DB);
  static const Color onSecondaryDark = Color(0xFF253140);
  static const Color secondaryContainerDark = Color(0xFF3B4858);
  static const Color onSecondaryContainerDark = Color(0xFFD6E4F7);
  static const Color secondaryFixedDark = Color(0xFFD6E4F7);
  static const Color secondaryFixedDimDark = Color(0xFF3B4858);
  static const Color onSecondaryFixedDark = Color(0xFF0F1C2B);
  static const Color onSecondaryFixedVariantDark  = Color(0xFF3B4858);

  static const Color errorDark = Color(0xFFFFB4AB);
  static const Color onErrorDark = Color(0xFF690005);
  static const Color errorContainerDark = Color(0xFF93000A);
  static const Color onErrorContainerDark = Color(0xFFFFDAD6);

  static const Color surfaceDimDark = Color(0xFF101418);
  static const Color surfaceDark = Color(0xFF101418);
  static const Color surfaceBrightDark = Color(0xFF36393E);

  static const Color surfContainerLowestDark = Color(0xFF0B0E13);
  static const Color surfContainerLowDark = Color(0xFF191C20);
  static const Color surfContainerDark = Color(0xFF1D2024);
  static const Color surfContainerHighDark = Color(0xFF272A2F);
  static const Color surfContainerHighestDark = Color(0xFF32353A);

  static const Color onSurfaceDark = Color(0xFFE1E2E8);
  static const Color onSurfVarDark  = Color(0xFFC3C7CF);
  static const Color outlineDark = Color(0xFF8D9199);
  static const Color outlineVariantDark = Color(0xFF42474E);

  static const Color inverseSurfaceDark = Color(0xFFE1E2E8);
  static const Color inverseOnSurfaceDark  = Color(0xFF2E3135);
  static const Color inversePrimaryDark = Color(0xFF35618E);

  static const Color scrimDark = Colors.black;
  static const Color shadowDark = Colors.black;


  static TextStyle _textStyle(double fontSize, FontWeight fontWeight) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      letterSpacing: 0,
      fontWeight: fontWeight,
      color: Colors.black,
    );
  }

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondaryColor,
      secondaryContainer: secondaryContainer,
      onSecondary: onSecondary,
      onSecondaryContainer: onSecondaryContainer,
      error: errorColor,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfVar,
      outline: outline,
      outlineVariant: outlineVariant,
      inversePrimary: inversePrimary,
      inverseSurface: inverseSurface,
      shadow: shadow,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)), // Text color
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: outline)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 4.0),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return secondaryColor;
        }
        return Colors.white;
      }),
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        color: Colors.black,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: errorColor,
      contentTextStyle: TextStyle(color: Colors.black),
      actionTextColor: onPrimary,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
    ),
    textTheme: TextTheme(
      bodySmall: _textStyle(12, FontWeight.normal),
      bodyMedium: _textStyle(14, FontWeight.normal),
      bodyLarge: _textStyle(16, FontWeight.normal),
      labelSmall: _textStyle(11, FontWeight.w500),
      labelMedium: _textStyle(12, FontWeight.w700),
      labelLarge: _textStyle(14, FontWeight.normal),
      titleSmall: _textStyle(14, FontWeight.normal),
      titleMedium: _textStyle(16, FontWeight.normal),
      titleLarge: _textStyle(22, FontWeight.normal),
      headlineSmall: _textStyle(24, FontWeight.normal),
      headlineMedium: _textStyle(28, FontWeight.w700),
      headlineLarge: _textStyle(28, FontWeight.w700),
      displaySmall: _textStyle(36, FontWeight.normal),
      displayMedium: _textStyle(45, FontWeight.normal),
      displayLarge: _textStyle(57, FontWeight.normal),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryDark,
    colorScheme: ColorScheme.dark(
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryContainerDark,
      onPrimaryContainer: onPrimaryContainerDark,
      secondary: secondaryDark,
      onSecondary: onSecondaryDark,
      secondaryContainer: secondaryContainerDark,
      onSecondaryContainer: onSecondaryContainerDark,
      error: errorDark,
      onError: onErrorDark,
      errorContainer: errorContainerDark,
      onErrorContainer: onSecondaryContainerDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: onSurfVarDark,
      outline: outlineDark,
      outlineVariant: outlineVariantDark,
      inversePrimary: inversePrimaryDark,
      inverseSurface: inverseSurfaceDark,
      scrim: scrimDark,
      shadow: shadow,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textTheme: ButtonTextTheme.primary,
    ),
    checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(secondaryColor)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(secondaryDark),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // Button shape
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
      ),
    ),
    textTheme: lightTheme.textTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: outlineDark)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryDark),
      ),
    ),
  );
}