import 'package:flutter/material.dart';

class CustomColors {
  static const dividerLine = Color(0xffE4E4EE);
  static const cardColor = Color(0xffE9ECF1);
  static const textColorBlack = Color(0xff171717);
  static const firstGradientColor = Color(0xff408ADE);
  static const secondGradientColor = Color(0xff5286CD);

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF2F3F8),
      colorScheme: const ColorScheme.light(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFEEEEEE),
      )
  );

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xff171717),
      colorScheme: const ColorScheme.dark(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      )
  );
}
