import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle fadedTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Color(0x99FFFFFF),
);

final TextStyle whiteHeadingTextStyle = GoogleFonts.montserrat(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle categoryTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 11,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle selectedCategoryTextStyle = categoryTextStyle.copyWith(
  color: Color(0xFF13A8AE),
);

final TextStyle eventTitleTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Color(0xFF000000),
);

final TextStyle eventwhiteTitleTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 38,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle eventLocationTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 18,
  fontWeight: FontWeight.w800,
  color: Color(0xFF000000),
);

final TextStyle punchLine1TextStyle = GoogleFonts.montserrat(
  fontSize: 24,
  fontWeight: FontWeight.w800,
  color: Color(0xFF13A8AE),
);

final TextStyle punchLine2TextStyle = punchLine1TextStyle.copyWith(
  color: Color(0xFF000000),
);
