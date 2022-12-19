import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/widgets/universal_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.title});

  final String title;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
          child: universalButton(250, 70, () {Navigator.pushNamed(context, ConstantScreens.devScreen);}, "Go to Dev screen"),
          ),
          const SizedBox(height: 30),
          Center(
          child: universalButton(250, 70, () {Navigator.pushNamed(context, ConstantScreens.boardScreen);}, "Go to Board Screen"),
          ),
        ],
      ),
    );
  }
}
