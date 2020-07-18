import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String appName = "IMDB Movies";

///------------------------------------Screen Size------------------------------
const double baseScreenWidth = 300;
const double baseScreenHeight = 812;

//App Color
const Color appPrimaryDarkColor = Color(0xFF000000);
const Color appAccentColor = Color(0xFF5468ff);
const Color appAccentDarkColor = Color(0xFF3d56f0);
const Color appTextTitle = Color(0xFF344356);
const Color appTextDetail = Color(0xFF596775);
const Color appTextLight = Color(0xFFf3f5f9);
const Color appTextLightTwo = Color(0xFF848e99);
const Color appBackground = Color.fromRGBO(244, 245, 249, 1);
const Color appProgress = Color(0xFF01d9cd);

const Color lightPrimary = Color(0xfffcfcff);
const Color darkPrimary = Colors.black;
const Color lightAccent = Colors.blue;
const Color darkAccent = Colors.blueAccent;
const Color lightBG = Color(0xfffcfcff);
const Color darkBG = Colors.black;
const Color badgeColor = Colors.red;
const Color contentTitleColor = Color(0xFF5c6977);
const Color contentDataColor = Color(0xFFc0c4cb);



class Constants {
  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

///-------------------------from colors.drat------------------------------------
const appBarBGColor = Color(0xFF2E9085);
const contentColor = Color.fromRGBO(38, 38, 47, 1);
const blueContentColor = Color(0xFF0277BD);
const blueColor = Color.fromRGBO(73, 111, 250, 1);
const greenColor = Color.fromRGBO(0, 216, 204, 1);
const colortry = Color(0xFF0277BD);
const chartGreen = Color(0xFF4caf50);
const chartGray = Color(0xFF808b97);
const chartRed = Color(0xFFf30f00);
const chartYellow = Color(0xFFfb9900);
const appWhiteColor = Color(0xFFffffff);

const colorHeader = Color(0xFF279fa4);
const colorSubHeader = Color(0xFF65c080);
const lineColor = Color(0xFFF7F4F3);
const tabGreenColor = Color(0xFF146265);

const sidebarColor = Color(0xFFE68619);

const transWhite = Color(0xFF78ffffff);
const white = Color(0xFFffffff);
const black = Color(0xFF000000);
const pagebackgroundColor = Color(0xFFE2F2F2);
const searchTextColor = Color(0xFF7B7B7B);
const tabColor = Color(0xFF61C480);
const disableColor = Color(0xFFA8F2C2);
const transparent = Color(0x00000000);
const green = Color(0xFF4CAF50);
const orangeAccent = Color(0xFFFFAB40);
const deepOrange = Color(0xFFFF5722);
const blue = Color(0xFF2196F3);
const grey = Color(0xFFb5b3b3);

///-----------------Text style--------------------------------------------------
///
///
/// splash screen
///

const TextStyle movieContent = TextStyle(
    fontSize: 12.0,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    color: contentTitleColor);
const TextStyle dateTime =
    TextStyle(fontSize: 11.0, fontFamily: 'OpenSans', color: searchTextColor);

const TextStyle movieTitle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: black);const TextStyle movieSmallTitle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: black);

const TextStyle movieBigTitle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: black);

/*
const cardheadlineText = TextStyle(
  color: darkBG,
  fontSize: 20,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const cardDataHeadingText = TextStyle(
  color: contentDataColor,
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const cardDataValueText = TextStyle(
  color: contentDataColor,
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const TextStyle selectedTabStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: appPrimaryDarkColor
);

const TextStyle unselectedTabStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  color: appTextTitle
);


const TextStyle btnTextStyle = TextStyle(
  fontSize: 16,
  color: white,
  fontWeight: FontWeight.bold
);

*/
