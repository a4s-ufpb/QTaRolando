import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;
  final Color colorPrimary;
  final Color colorSecundary;

  Category({
    this.categoryId,
    this.name,
    this.icon,
    this.colorPrimary,
    this.colorSecundary,
  });
}

final tudoCategory = Category(
  categoryId: 0,
  name: "Tudo",
  icon: FontAwesomeIcons.search,
  colorPrimary: Color(0xFFED8B4E),
  colorSecundary: Color(0xFFEE4D5F),
);

final musicaCategory = Category(
  categoryId: 1,
  name: "Música",
  icon: FontAwesomeIcons.compactDisc,
  colorPrimary: Color(0xFFF54EA2),
  colorSecundary: Color(0xFFFF7676),
);

final socialCategory = Category(
  categoryId: 2,
  name: "Social",
  icon: FontAwesomeIcons.userAlt,
  colorPrimary: Color(0xFF7117EA),
  colorSecundary: Color(0xFFEA6060),
);

final congressoCategory = Category(
  categoryId: 3,
  name: "Congressos & Simpósios",
  icon: FontAwesomeIcons.solidComments,
  colorPrimary: Color(0xFF5B247A),
  colorSecundary: Color(0xFF1BCEDF),
);

final cursosCategory = Category(
  categoryId: 4,
  name: "Cursos",
  icon: FontAwesomeIcons.pencilAlt,
  colorPrimary: Color(0xFF622774),
  colorSecundary: Color(0xFFC53354),
);

final palestrasCategory = Category(
  categoryId: 5,
  name: "Palestras",
  icon: FontAwesomeIcons.solidCommentAlt,
  colorPrimary: Color(0xFF42E695),
  colorSecundary: Color(0xFF3BB2B8),
);

// final simposiosCategory = Category(
//   categoryId: 6,
//   name: "Simpósios",
//   icon: FontAwesomeIcons.solidComments,
//   colorPrimary: Color(0xFF184E68),
//   colorSecundary: Color(0xFF57CA85),
// );

// final tecnologiaCategory = Category(
//   categoryId: 7,
//   name: "Tecnologia",
//   icon: FontAwesomeIcons.microchip,
//   colorPrimary: Color(0xFF17EAD9),
//   colorSecundary: Color(0xFF6078EA),
// );

final categories = [
  tudoCategory,
  musicaCategory,
  socialCategory,
  congressoCategory,
  cursosCategory,
  palestrasCategory,
  // simposiosCategory,
  // tecnologiaCategory,
];
