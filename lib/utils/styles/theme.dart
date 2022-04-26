import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';

class CustomLightTheme {
  static Color iconColor = kDarkBlue;

  static Color drawerHeadlingColor = Colors.white;

  static TextStyle headline6(context) =>
      Theme.of(context).textTheme.headline6!.copyWith(
            color: kDarkBlue,
          );
  static TextStyle bodyLarge(context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            color: kDarkBlue,
            fontWeight: FontWeight.bold,
          );
  static TextStyle smallHeadline(context) =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: kDarkBlue,
            fontWeight: FontWeight.bold,
          );

  static TextStyle mediumHeadline(context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: kDarkBlue,
            fontWeight: FontWeight.bold,
          );
}

class CustomDarkTheme {
  static Color iconColor = Colors.white;
  static Color drawerHeadlingColor = Colors.white;

  static TextStyle bodyLarge(context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          );
  static TextStyle headline6(context) =>
      Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.white,
          );
  static TextStyle smallHeadline(context) =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          );

  static TextStyle kmediumHeadline(context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          );
}

ThemeData kLighTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: kScaffoldBGColor,
  drawerTheme: const DrawerThemeData(),
  dialogTheme: const DialogTheme(backgroundColor: Colors.white),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.pink,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(color: kDarkBlue),
    actionsIconTheme: IconThemeData(color: kDarkBlue),
    backgroundColor: kScaffoldBGColor,
  ),
);
ThemeData kDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xff171D2D),
  drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff171D2D)),
  dialogTheme: const DialogTheme(backgroundColor: Color(0xff171D2D)),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xff171D2D),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor: const Color(0xff1E2336),
);
