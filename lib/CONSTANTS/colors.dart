import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0xFFF4822A);
const primaryColorLight = Color(0xFFF18127);

const secondaryColor = Color(0xFFB19A7B);
const secondaryColorLight = Color(0xFFF18127);

const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);

const firstColor = Color(0xFF01ccd2);
const secondColor = Color(0xFFff1652);
const thirdColor = Color(0xFFE8E9EB);
const fourthColor = Color(0xFF9C9C9C);



final Map<int, Color> _yellow700Map = {
  50: thirdColor,
  100: thirdColor,
  200: thirdColor,
  300: thirdColor,
  400: thirdColor,
  500: thirdColor,
  600: thirdColor,
  700: thirdColor,
  800: thirdColor,
  900: thirdColor,
};

final MaterialColor thirdSwatch =
  MaterialColor(thirdColor.value, _yellow700Map);