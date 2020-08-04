import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int selectedCategoryId = 0;
  Color colorPrimary = Color(0xFFED8B4E);
  Color colorSecundary = Color(0xFFEE4D5F);

  void UpdateCategoryId(
      int selectedCategoryId, Color colorSelected, Color colorSecundary) {
    this.selectedCategoryId = selectedCategoryId;
    this.colorPrimary = colorSelected;
    this.colorSecundary = colorSecundary;
    notifyListeners();
  }
}
