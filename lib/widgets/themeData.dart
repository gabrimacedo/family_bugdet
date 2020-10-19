import 'package:flutter/material.dart';

class ThemeDataDelay with ChangeNotifier {
  var _textTheme = ThemeData.light().textTheme;

  set textTheme(TextTheme textTheme) {
    this._textTheme = textTheme;
    notifyListeners();
  }

  TextTheme get customTextTheme => _textTheme;
}
