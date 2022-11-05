import 'package:flutter/widgets.dart';

@optionalTypeArgs
abstract class StateWithLifecycle<T extends StatefulWidget> extends State<T> {
  bool _alreadyBuild = false;

  void preFirstBuildInit();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_alreadyBuild) {
      preFirstBuildInit();
      _alreadyBuild = true;
    }
  }
}
