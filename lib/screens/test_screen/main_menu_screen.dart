import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/screens/test_screen/main_menu_store.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends StateWithLifecycle<MainMenuScreen> {
  final MainMenuStore _mainMenuStore = MainMenuStore();

  @override
  void preFirstBuildInit() {
    _mainMenuStore.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              child: Container(
                width: 100,
                height: 70,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(":)"),
              ),
              onTap: () {
                _mainMenuStore.getHelloWorld(context);
              },
            ),
          ),
          Observer(
            builder: (_) => Center(
              child: Text(_mainMenuStore.greeting),
            ),
          ),
        ],
      ),
    );
  }
}
