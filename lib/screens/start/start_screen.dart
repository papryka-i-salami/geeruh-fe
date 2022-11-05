import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';

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
            child: ElevatedButton(
              child: const Text("Go to Main Menu"),
              onPressed: () {
                Navigator.pushNamed(context, ConstantScreens.mainMenuScreen);
              },
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              child: const Text("Go to Board Screen"),
              onPressed: () {
                Navigator.pushNamed(context, ConstantScreens.boardScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
