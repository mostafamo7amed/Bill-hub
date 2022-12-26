import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    color: color,
  );
}
// regular
TextStyle getRegularStyle({double fontSize = FontSizeManager.s12, required color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getBoldStyle({double fontSize = FontSizeManager.s12, required color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getSemiBoldStyle({double fontSize = FontSizeManager.s12, required color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
TextStyle getMediumStyle({double fontSize = FontSizeManager.s12, required color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
TextStyle getLightStyle({double fontSize = FontSizeManager.s12, required color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}