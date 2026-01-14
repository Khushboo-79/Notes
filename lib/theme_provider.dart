import 'package:flutter/material.dart';

class themeProvider extends ChangeNotifier{

  bool _isdarkMode = false;

  bool getThemeValue() => _isdarkMode;

  void updateTheme({required bool value}){
    _isdarkMode = value;
    notifyListeners();
  }
}