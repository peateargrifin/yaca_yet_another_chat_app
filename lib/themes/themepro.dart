import 'package:flutter/material.dart';

import 'light_mode.dart';

class themeprovider extends ChangeNotifier {
  ThemeData thememode = lightMode;

  ThemeData get themedata => thememode;

  bool get isDark => thememode == darkMode;

  set themeData(ThemeData themda) {
    thememode = themda;
    notifyListeners();
  }

  void toggleTheme() {
    thememode = isDark ? lightMode : darkMode;
    notifyListeners();
  }
}
