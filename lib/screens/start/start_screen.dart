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
      body: Center(
        child: ElevatedButton(
          child: const Text("Go to Main Menu"),
          onPressed: () {
            Navigator.pushNamed(context, ConstantScreens.MainMenuScreen);
          },
        ),
      ),
    );
  }
}
