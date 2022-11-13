import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/screens/dev/dev_store.dart';
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
        title: const Text("Main Menu"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              key: const Key("HelloWorld"),
              child: Container(
                width: 100,
                height: 70,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(":)"),
              ),
              onTap: () {
                _devStore.getHelloWorld(context);
              },
            ),
          ),
          Observer(
            builder: (_) => Center(
              child: Text(_devStore.greeting),
            ),
          ),
        ],
      ),
    );
  }
}
