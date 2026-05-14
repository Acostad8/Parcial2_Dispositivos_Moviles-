//SIRVE PARA CAMBIAR EL COLOR DE LA APP Y EL TEMA CLARO U OSCURO
//EL COLOR SE CAMBIA EN LA VARIABLE SELECTCOLOR, SI SE QUIERE CAMBIAR EL TEMA CLARO U OSCURO SE CAMBIA LA VARIABLE BANDERA,
// SI ES 1 ES OSCURO Y SI ES 0 ES CLARO

import 'package:flutter/material.dart';

final List<Color> colorsTheme = [Colors.green, Colors.blue];

class AppTheme {
  final int selectColor;
  AppTheme({required this.selectColor});
  ThemeData themeData(int bandera) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorsTheme[selectColor],

      brightness: bandera == 1 ? Brightness.dark : Brightness.light,

      appBarTheme: AppBarTheme(
        backgroundColor: colorsTheme[selectColor],
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
