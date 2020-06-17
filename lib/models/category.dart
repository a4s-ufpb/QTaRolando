import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;

  Category({this.categoryId, this.name, this.icon});
}

final tudoCategory = Category(
  categoryId: 0,
  name: "Tudo",
  icon: Icons.search,
);

final musicaCategory = Category(
  categoryId: 1,
  name: "Música",
  icon: Icons.music_note,
);

final socialCategory = Category(
  categoryId: 2,
  name: "Social",
  icon: Icons.location_on,
);

final congressoCategory = Category(
  categoryId: 3,
  name: "Congressos",
  icon: Icons.mic,
);

final cursosCategory = Category(
  categoryId: 4,
  name: "Cursos",
  icon: Icons.mode_edit,
);

final palestrasCategory = Category(
  categoryId: 5,
  name: "Palestras",
  icon: Icons.record_voice_over,
);

final simposiosCategory = Category(
  categoryId: 6,
  name: "Cursos",
  icon: Icons.comment,
);

final tecnologiaCategory = Category(
  categoryId: 7,
  name: "Tecnologia",
  icon: Icons.memory,
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
