import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier{
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: Colors.black,
        cardColor: Colors.white60,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      backgroundColor: Colors.white38,
      textTheme: ThemeData.light().textTheme,
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.white,
        cardColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white10,
        fontFamily: 'Roboto',
        backgroundColor: Colors.blue,
        textTheme: ThemeData.dark().textTheme,
        );
  }
}