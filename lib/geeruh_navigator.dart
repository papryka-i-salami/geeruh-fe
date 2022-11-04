import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/screens/test_screen/main_menu_screen.dart';

Route geeruhPageRoute(BuildContext context, String screen) {
  switch (screen) {
    case ConstantScreens.MainMenuScreen:
      return MaterialPageRoute(builder: (context) => const MainMenuScreen());
    default:
      throw Exception("Incorrect screen path");
  }
}
