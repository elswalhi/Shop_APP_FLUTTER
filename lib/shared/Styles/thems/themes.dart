import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/Styles/Colors.dart';

ThemeData darkTheme=ThemeData(
  textTheme:const TextTheme(
    bodyText1:  TextStyle(
      fontFamily: "janna",
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: 18,
    ),
  ) ,
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),

  primarySwatch:defultColor ,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0 ,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,

    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),
  ) ,
);

ThemeData lightTheme=ThemeData(
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
      fontFamily:'janna' ,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 18,
    ),
  ),
  primarySwatch:defultColor ,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defultColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  appBarTheme:const AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    elevation: 0 ,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,

    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
  ) ,
);