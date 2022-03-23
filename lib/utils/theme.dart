import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SocialOutTheme {

  static final SocialOutTheme _instance = SocialOutTheme._internal();


  /* Typography */
  static double xxl = 32;
  static double xl = 24;
  static double lg = 20;
  static double md = 18;
  static double sm = 16;
  static double xs = 14;
  static double xxs = 12;
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w900;  

  /* COLOR SCHEME */
  static Color primary = HexColor('22577A');
  static Color onPrimary = Colors.white;
  static Color secondary = HexColor('38A3A5');
  static Color onSecondary = Colors.white;
  static Color error = HexColor('ED4337');
  static Color onError = Colors.white;
  static Color background = Colors.white;
  static Color onBackground = Colors.black;
  static Color surface = Colors.black;
  static Color onSurface = Colors.white;

  factory SocialOutTheme() {
    return _instance;
  }

  SocialOutTheme._internal();
}