import 'package:flutter/material.dart';
import 'package:geeruh/screens/test_screen/main_menu_store.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final MainMenuStore _mainMenuStore = MainMenuStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            width: 100,
            height: 70,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(":)"),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
