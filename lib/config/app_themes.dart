import 'package:movie_app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    unselectedWidgetColor: AppLightColors.primaryColor,
    scaffoldBackgroundColor: AppLightColors.appBackgroundColor,
    primaryColor: AppLightColors.primaryColor,
    listTileTheme: const ListTileThemeData().copyWith(iconColor: Colors.black),
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: AppLightColors.primaryColor,
      secondary: AppLightColors.secondaryColor,
      surface: AppLightColors.appBackgroundColor,
      onSurface: AppLightColors.whiteColor,
      primaryContainer: AppLightColors.grayColor,
      secondaryContainer: AppLightColors.lightGrayColor,
      error: AppLightColors.redColor,
      tertiary: AppLightColors.greenColor,
      inverseSurface: Colors.black,
      shadow: const Color(0x0fff4f4f),
      onSecondaryContainer: AppLightColors.cardBackgroundColor,
      onTertiaryContainer: AppLightColors.cardWhiteColor,
      tertiaryContainer: AppLightColors.scaffoldBackground,
      inversePrimary: AppLightColors.settingCardBackground,

    ),

    appBarTheme: const AppBarTheme().copyWith(
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: AppLightColors.appBackgroundColor,
      dragHandleColor: AppLightColors.grayTextColor,
    ),
    shadowColor: AppLightColors.grayColor,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppLightColors.darkGrayColor,
        height: 0.0.h,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppLightColors.grayTextColor,
        height: 0.0.h,
      ),
      displayMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0.h,
      ),
      displayLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppLightColors.textColor,
        height: 0.0.h,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0.0.h,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0.0.h,
      ),
      headlineLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppLightColors.textColor,
        height: 0.0.h,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppDarkColors.backgroundColor,
    primaryColor: AppDarkColors.primaryColor,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.light,
      primary: AppDarkColors.primaryColor,
      secondary: AppDarkColors.secondaryColor,
      surface: AppDarkColors.backgroundColor,
      primaryContainer: AppDarkColors.grayColor,
      secondaryContainer: AppDarkColors.lightGrayColor,
      //temp dark gray
      shadow: AppDarkColors.darkGrayColor,
      // onSecondary: AppDarkColors.whiteColor,
      error: AppDarkColors.redColor,
      tertiary: AppDarkColors.greenColor,

      //fonts
      onPrimary: AppDarkColors.textColor,
      onSecondary: AppDarkColors.textLightColor,
      onInverseSurface: AppDarkColors.whiteColor,

      //Cards
      onPrimaryContainer: AppDarkColors.cardHeaderColor,
      onSecondaryContainer: AppDarkColors.cardBackgroundColor,
      onTertiaryContainer: AppDarkColors.cardWhiteColor,

      //scaffoldBackground
      tertiaryContainer: AppDarkColors.backgroundColor,

      //settingCardColor
      inversePrimary: AppDarkColors.settingCardBackground,
    ),
    iconTheme: const IconThemeData().copyWith(
      color: AppDarkColors.primaryColor,
    ),
    //  bottomSheetTheme: const BottomSheetThemeData().copyWith(
    //   backgroundColor: AppDarkColors.appBackgroundColor,
    //   dragHandleColor: AppDarkColors.grayTextColor,
    // ),
    shadowColor: AppDarkColors.grayColor,
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppDarkColors.darkGrayColor,
        height: 0.0.h,
      ),
      displayMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppDarkColors.grayColor,
        height: 0.0.h,
      ),
      displayLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.textColor,
        height: 0.0.h,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppLightColors.grayColor,
        height: 0.0.h,
      ),
      headlineLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppLightColors.grayColor,
        height: 0.0.h,
      ),
    ),
  );
}
