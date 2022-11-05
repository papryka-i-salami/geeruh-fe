import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/screens/board/board_screen.dart';
import 'package:geeruh/screens/start/start_screen.dart';
import 'package:geeruh/screens/test_screen/main_menu_screen.dart';

Route geeruhPageRoute(BuildContext context, String screen) {
  switch (screen) {
    case ConstantScreens.MainMenuScreen:
      return MaterialPageRoute(builder: (_) => const MainMenuScreen());

    case ConstantScreens.StartScreen:
      return MaterialPageRoute(
        builder: (_) => const StartScreen(
          title: 'Home',
        ),
      );

    case ConstantScreens.BoardScreen:
      return MaterialPageRoute(
        builder: (_) => const BoardScreen(),
      );

    default:
      throw Exception("Incorrect screen path");
  }
}
