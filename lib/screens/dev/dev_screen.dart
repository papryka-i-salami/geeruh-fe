import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/screens/dev/dev_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';

class DevScreen extends StatefulWidget {
  const DevScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DevScreenState createState() => _DevScreenState();
}

class _DevScreenState extends StateWithLifecycle<DevScreen> {
  final DevStore _devStore = DevStore();

  @override
  void preFirstBuildInit() {
    _devStore.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dev screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                key: const Key("LoginButton"),
                child: Container(
                  width: 100,
                  height: 70,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text("Login"),
                ),
                onTap: () async {
                  _devStore.login(context);
                },
              ),
              GestureDetector(
                key: const Key("IssuesButton"),
                child: Container(
                  width: 100,
                  height: 70,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text("Issues"),
                ),
                onTap: () async {
                  _devStore.getIssues(context);
                },
              ),
            ],
          ),
          Observer(
            builder: (_) => Center(
              child: Text(_devStore.issues.toString()),
            ),
          ),
          Row(
            children: [
              _colorContainer(GeeColors.primary1, "primary1"),
              _colorContainer(GeeColors.primary2, "primary2"),
              _colorContainer(GeeColors.primary3, "primary3"),
              _colorContainer(GeeColors.primary4, "primary4"),
              _colorContainer(GeeColors.primary5, "primary5"),
            ],
          ),
          Row(
            children: [
              _colorContainer(GeeColors.secondary1, "secondary1"),
              _colorContainer(GeeColors.secondary2, "secondary2"),
              _colorContainer(GeeColors.secondary3, "secondary3"),
              _colorContainer(GeeColors.secondary4, "secondary4"),
              _colorContainer(GeeColors.secondary5, "secondary5"),
            ],
          ),
          Row(
            children: [
              _colorContainer(GeeColors.gray1, "gray1"),
              _colorContainer(GeeColors.gray2, "gray2"),
              _colorContainer(GeeColors.gray3, "gray3"),
              _colorContainer(GeeColors.gray4, "gray4"),
              _colorContainer(GeeColors.gray5, "gray5"),
              _colorContainer(GeeColors.gray6, "gray6"),
              _colorContainer(GeeColors.gray7, "gray7"),
              _colorContainer(GeeColors.gray8, "gray8"),
              _colorContainer(GeeColors.gray9, "gray9"),
              _colorContainer(GeeColors.gray10, "gray10"),
            ],
          ),
          Row(
            children: [
              _colorContainer(GeeColors.red, "red"),
              _colorContainer(GeeColors.orange, "orange"),
              _colorContainer(GeeColors.white, "white"),
            ],
          ),
          Row(children: const [
            Text("Heading1", style: GeeTextStyles.heading1),
            Text("Heading2", style: GeeTextStyles.heading2),
            Text("Heading3", style: GeeTextStyles.heading3),
            Text("Heading4", style: GeeTextStyles.heading4),
            Text("Heading5", style: GeeTextStyles.heading5),
            Text("Heading6", style: GeeTextStyles.heading6),
          ]),
          Row(children: const [
            Text("Paragraph1", style: GeeTextStyles.paragraph1),
            Text("Paragraph2", style: GeeTextStyles.paragraph2),
            Text("Paragraph3", style: GeeTextStyles.paragraph3),
          ]),
        ],
      ),
    );
  }
}

Widget _colorContainer(Color color, String caption) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 1),
    ),
    child: Center(child: Text(caption)),
  );
}
