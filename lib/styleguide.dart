import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xFF212226),
    accentColor: Colors.white10,
    buttonColor: Colors.white,
    fontFamily: "Caros",
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 14,
        fontFamily: "Caros",
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      headline2: TextStyle(
        fontSize: 24,
        fontFamily: "Caros",
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 14,
        fontFamily: "Caros",
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: 16,
        fontFamily: "Caros",
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(color: Color(0xff1f655d)), textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.white.withOpacity(0.5), selectionHandleColor: Colors.white,));

ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.grey[300],
    buttonColor: Color(0xFF212226),
    fontFamily: "Caros",
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 14,
        fontFamily: "Caros",
        fontWeight: FontWeight.w600,
        color: Color(0xFF444444),
      ),
      headline2: TextStyle(
        fontSize: 24,
        fontFamily: "Caros",
        fontWeight: FontWeight.bold,
        color: Color(0xFF212226),
      ),
      headline3: TextStyle(
        fontSize: 14,
        fontFamily: "Caros",
        color: Color(0xFF212226),
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: 16,
        fontFamily: "Caros",
        color: Color(0xFF212226),
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
        color: Color(0xff1f655d),
        actionsIconTheme: IconThemeData(color: Colors.white)), textSelectionTheme: TextSelectionThemeData(selectionColor: Color(0xFF212226).withOpacity(0.5), selectionHandleColor: Color(0xFF444444),));

final TextStyle fadedTextStyle = TextStyle(
  fontSize: 14,
  fontFamily: "Caros",
  fontWeight: FontWeight.normal,
  color: Color(0xFF444444),
);

final TextStyle whiteHeadingTextStyle = TextStyle(
  fontSize: 40,
  fontFamily: "Caros",
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle categoryTextStyle = TextStyle(
  fontSize: 14,
  fontFamily: "Caros",
  fontWeight: FontWeight.w600,
  color: Color(0xFFFFFFFF),
);

final TextStyle selectedCategoryTextStyle = categoryTextStyle.copyWith(
  color: Color(0xFF13A8AE),
);

final TextStyle eventTitleTextStyle = TextStyle(
  fontSize: 24,
  fontFamily: "Caros",
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

final TextStyle eventwhiteTitleTextStyle = TextStyle(
  fontSize: 40,
  fontFamily: "Caros",
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle eventLocationTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: "Caros",
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

final TextStyle eventoDescription = TextStyle(
  fontSize: 17,
  fontFamily: "Caros",
  fontWeight: FontWeight.w500,
);

final TextStyle eventoSubtitle = TextStyle(
  fontFamily: "Caros",
);

final TextStyle punchLine1TextStyle = TextStyle(
  fontSize: 21,
  fontFamily: "Caros",
  fontWeight: FontWeight.w800,
  color: Color(0xFF13A8AE),
);

final TextStyle punchLine2TextStyle = punchLine1TextStyle.copyWith(
  color: Color(0xFF000000),
);
