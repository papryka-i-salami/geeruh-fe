import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/screens/start/start_store.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/title_list.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.title});

  final String title;

  @override
  StateWithLifecycle<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends StateWithLifecycle<StartScreen> {
  final StartStore _startStore = StartStore();

  @override
  void preFirstBuildInit() {
    _startStore.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          //newProject(700, 700),
          Observer(
            builder: (_) =>
                titleList(500, 500, _startStore.entries, "My Projects"),
          ),
          const SizedBox(height: 30),
          Center(
            child: universalButton(250, 70, () {
              Navigator.pushNamed(context, ConstantScreens.devScreen);
            }, "Add project"),
          ),
          const SizedBox(height: 30),
          Center(
            child: geeUniversalButton(250, 70, () {
              Navigator.pushNamed(context, ConstantScreens.devScreen);
            }, "Go to Dev screen"),
          ),
          const SizedBox(height: 30),
          Center(
            child: geeUniversalButton(250, 70, () {
              Navigator.pushNamed(context, ConstantScreens.boardScreen);
            }, "Go to Board Screen"),
          ),
        ],
      ),
    );
  }
}
