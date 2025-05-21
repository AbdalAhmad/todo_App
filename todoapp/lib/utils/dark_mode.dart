import 'package:flutter/material.dart';

class darkMode extends ChangeNotifier {
  bool _isDark = false;
 
bool get isDarkMode => _isDark;


  ThemeData get currentTheme => _isDark ? darkTheme : lightTheme;

  void toggleDarkMode() {
    _isDark= !_isDark;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  primarySwatch: Colors.yellow,

);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  
);
