import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class MyTheme {
  //Theme Dark
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.pink,
    hintColor: AppConstants.darkapphintGreyColor,
    dividerColor: AppConstants.appBorderColor,
    indicatorColor: AppColors.primary,
    primaryColorDark: AppConstants.white,
    primaryColorLight: AppConstants.appMainGreyColor,
    scaffoldBackgroundColor: AppColors.bgColor,
    primaryColor: AppColors.primary,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(AppConstants.white))),
    iconTheme: const IconThemeData(color: AppConstants.white),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppConstants.darkbg,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
    ),
//AppBar Theme
    appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.darkbg,
        surfaceTintColor: Colors.transparent),
//check box
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(AppConstants.white),
      fillColor: MaterialStateProperty.all(AppColors.primary),
    ),
//divider
    dividerTheme: const DividerThemeData(
        color: AppConstants.appBorderColor, thickness: 1),
//textformfield input decoration
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      hintStyle: TextStyle(
        color: AppConstants.darkapphintGreyColor,
        fontSize: 16,
        fontFamily: AppConstants.fontFamily,
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
              color: Color(0xFF44484E),
              width: 1)), // AppConstants.appBorderColor
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: Color(0xFF44484E), width: 1)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF44484E), width: 1),
      ),
    ),

    // cardColor: const Color.fromRGBO(21, 21, 37, 1),

    // secondaryHeaderColor: const Color.fromRGBO(253, 253, 253, 1),
    splashColor: AppConstants.darkbg,
//Text theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          height: 1.2,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          fontFamily: AppConstants.fontFamily,
          fontStyle: FontStyle.normal,
          color: AppConstants.white),
      displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      headlineMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      headlineSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      titleLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontFamily: AppConstants.fontFamily,
        color: AppConstants.white,
      ),
    ),
    // bottomSheetTheme: const BottomSheetThemeData(
    //   backgroundColor: Color.fromRGBO(1, 1, 1, 1),
    // ),
    // appBarTheme: const AppBarTheme(
    //   actionsIconTheme: IconThemeData(
    //     color: Colors.black,
    //   ),
    //   backgroundColor: Color.fromRGBO(253, 191, 45, 1),
    //   titleTextStyle: TextStyle(
    //     color: Colors.black,
    //   ),
    // ),
    // iconTheme: const IconThemeData(color: Colors.black),
    // dialogTheme: DialogTheme(
    //     backgroundColor: const Color.fromRGBO(21, 21, 37, 1),
    //     iconColor: Colors.black,
    //     contentTextStyle: const TextStyle(color: Colors.black),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //     elevation: 2),
    // colorScheme: const ColorScheme(
    //     background: Color.fromRGBO(41, 83, 150, 1),
    //     brightness: Brightness.dark),
  );

//Theme Lighht
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: AppConstants.white,
    hintColor: AppConstants.appMainGreyColor,
    dividerColor: AppConstants.appBorderColor,
    indicatorColor: AppColors.primary,
    primaryColorDark: AppConstants.black,
    primaryColorLight: AppConstants.appMainGreyColor,
    primaryColor: AppColors.primary,
    splashColor: AppColors.primary,
    secondaryHeaderColor: Colors.black,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(AppConstants.black))),
    iconTheme: const IconThemeData(color: AppConstants.black),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppConstants.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.white,
        surfaceTintColor: Colors.transparent),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(AppConstants.white),
      fillColor: MaterialStateProperty.all(AppColors.primary),
    ),
    dividerTheme: const DividerThemeData(
        color: AppConstants.appBorderColor, thickness: 1),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      hintStyle: TextStyle(
        color: AppConstants.appMainGreyColor,
        fontSize: 16,
        fontFamily: AppConstants.fontFamily,
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1),
      ),
    ),
    // cardColor: const Color.fromRGBO(212, 223, 244, 1),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
          height: 1.2,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          fontFamily: AppConstants.fontFamily,
          fontStyle: FontStyle.normal,
          color: AppConstants.black),
      displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      headlineMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      headlineSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      titleLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontFamily: AppConstants.fontFamily,
        color: Color(0xff181C1F),
      ),
    ),
    buttonTheme: ButtonThemeData(buttonColor: AppColors.primary, height: 50),
    // backgroundColor: const Color.fromRGBO(0, 65, 106, 1),
    // bottomSheetTheme: const BottomSheetThemeData(
    //   backgroundColor: Color.fromRGBO(248, 248, 255, 1),
    // ),
    // appBarTheme: const AppBarTheme(
    //   actionsIconTheme: IconThemeData(
    //     color: Colors.white,
    //   ),
    //   backgroundColor: Color.fromRGBO(0, 65, 106, 1),
    //   titleTextStyle: TextStyle(
    //     color: Colors.white,
    //   ),
    // ),
// dialogTheme: DialogTheme(
    //     backgroundColor: Colors.white,
    //     iconColor: Colors.black,
    //     contentTextStyle: const TextStyle(color: Colors.black),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //     elevation: 2),
  );
}

class AppConstants {
  static const String appName = 'MMG';
  static const String fontFamily = "PlusJakartaSans";

  /// App Colors  Light
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF303030);
  static const appBorderColor = Color(0xFFDCE5F2);

  static const appMainGreyColor = Color(0xFF8391A1);

  /// App Colors  dark
  static const dark = Color(0xFFFFFFFF);
  static const darkbg = Color(0xFF111111);
  static const darkappBorderColor = Color(0xFF44484E);

  static const darkappDiscriptioGreyColor = Color(0xFF8391A1);
  static const darkapphintGreyColor = Color(0xFF72787E);
  static const containerColor = Color(0xFF2E2E2E);
  static const containerBorderColor = Color(0xFFDCE4F2);
}
