import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int selectedCategoryId = 0;
  Color colorPrimary = Color(0xFF8c5b4d);

  void UpdateCategoryId(int selectedCategoryId, Color colorSelected) {
    this.selectedCategoryId = selectedCategoryId;
    this.colorPrimary = colorSelected;
    notifyListeners();
  }
}
