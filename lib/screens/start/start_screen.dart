import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/screens/start/start_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_nav_bar.dart';
import 'package:geeruh/widgets/gee_title_list.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';
import 'package:geeruh/widgets/gee_popup.dart';
import 'package:geeruh/widgets/gee_project_editor/gee_project_editor.dart';
import 'package:geeruh/widgets/gee_list_button.dart';
import 'package:geeruh/widgets/gee_future_child.dart';

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
      appBar: const GeeNavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Observer(
                    builder: (_) => GeeFutureChild(
                      loaded: _loadedProjects,
                      status: _startStore.futureGetProjects.status,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: geeUniversalButton(250, 70, () async {
                      await GeePopup(
                        context,
                        content: GeeProjectEditor(
                            width: 700, heigth: 700, startStore: _startStore),
                      ).show();
                    }, "Add project"),
                  ),
                ],
              ),
              Observer(
                builder: (_) => GeeFutureChild(
                  loaded: _loadedBoards,
                  status: _startStore.futureGetProjects.status,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: geeUniversalButton(250, 70, () {
              Navigator.pushNamed(context, ConstantScreens.devScreen);
            }, "Go to Dev screen"),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _loadedProjects() {
    return geeTitleList(
        500,
        500,
        _startStore.projects
            .map((project) => geeListButton(() async {
                  await GeePopup(context,
                          content: GeeProjectEditor(
                              width: 700,
                              heigth: 700,
                              startStore: _startStore,
                              projectRes: project))
                      .show();
                }, project.name))
            .toList(),
        "My Projects",
        "images/Project.png",
        GeeColors.secondary1);
  }

  Widget _loadedBoards() {
    return geeTitleList(
        500,
        500,
        _startStore.projects
            .map((project) => geeListButton(() {
                  Navigator.pushNamed(
                    context,
                    ConstantScreens.boardScreen,
                    arguments: {'projectCode': project.code},
                  );
                }, "Board for ${project.name}"))
            .toList(),
        "My Boards",
        "images/Boards.png",
        GeeColors.secondary2);
  }
}
