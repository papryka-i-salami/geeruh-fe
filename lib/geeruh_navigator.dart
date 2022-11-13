import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/screens/board/board_screen.dart';
import 'package:geeruh/screens/dev/dev_screen.dart';
import 'package:geeruh/screens/start/start_screen.dart';

Route geeruhPageRoute(BuildContext context, String screen) {
  switch (screen) {
    case ConstantScreens.devScreen:
      return MaterialPageRoute(builder: (_) => const DevScreen());

    case ConstantScreens.startScreen:
      return MaterialPageRoute(
        builder: (_) => const StartScreen(
          title: 'Home',
        ),
      );

    case ConstantScreens.boardScreen:
      return MaterialPageRoute(
        builder: (_) => const BoardScreen(),
      );

    default:
      throw Exception("Incorrect screen path");
  }
}
