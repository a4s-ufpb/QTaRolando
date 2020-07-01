import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;
  final Color color;

  Category({this.categoryId, this.name, this.icon, this.color});
}

final tudoCategory = Category(
  categoryId: 0,
  name: "Tudo",
  icon: FontAwesomeIcons.search,
  color: Color(0xFF795548),
);

final musicaCategory = Category(
  categoryId: 1,
  name: "Música",
  icon: FontAwesomeIcons.compactDisc,
  color: Color(0xFFFF9800),
);

final socialCategory = Category(
  categoryId: 2,
  name: "Social",
  icon: FontAwesomeIcons.userAlt,
  color: Color(0xFFE91E63),
);

final congressoCategory = Category(
  categoryId: 3,
  name: "Congressos",
  icon: FontAwesomeIcons.microphone,
  color: Color(0xFF1E88E5),
);

final cursosCategory = Category(
  categoryId: 4,
  name: "Cursos",
  icon: FontAwesomeIcons.pencilAlt,
  color: Color(0xFFE53935),
);

final palestrasCategory = Category(
  categoryId: 5,
  name: "Palestras",
  icon: FontAwesomeIcons.solidCommentAlt,
  color: Color(0xFF4CAF50),
);

final simposiosCategory = Category(
  categoryId: 6,
  name: "Simpósios",
  icon: FontAwesomeIcons.solidComments,
  color: Color(0xFF009688),
);

final tecnologiaCategory = Category(
  categoryId: 7,
  name: "Tecnologia",
  icon: FontAwesomeIcons.microchip,
  color: Color(0xFF00BCD4),
);

final categories = [
  tudoCategory,
  musicaCategory,
  socialCategory,
  congressoCategory,
  cursosCategory,
  palestrasCategory,
  simposiosCategory,
  tecnologiaCategory,
];
