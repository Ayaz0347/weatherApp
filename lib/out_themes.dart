import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weatherapp/const/colors.dart';
class CustomTheme {
static final lightTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Vx.gray800,
  cardColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Vx.gray600,
  )
);

static final darkTheme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: bgColor,
    primaryColor: Vx.white,
    cardColor: bgColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    )
);
}

