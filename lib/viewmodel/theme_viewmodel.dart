import 'package:flutter/material.dart';
import 'package:new_app/global/global_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewmodel extends ChangeNotifier {
  int _color = 0;

  int get getColor {
    return _color;
  }


  void setColor(int color)async {
    if (color > themes.length - 1) return;
    _color = color;
    // 持久化保持
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("color", color);
    notifyListeners();
  }
}