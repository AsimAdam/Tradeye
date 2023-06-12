// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue[300],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey.shade200,
      toolbarTextStyle: TextStyle(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey[800],
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextStyle(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
