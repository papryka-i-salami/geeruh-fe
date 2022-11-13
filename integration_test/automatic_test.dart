import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geeruh/global_constants.dart';
import 'package:integration_test/integration_test.dart';
import 'package:geeruh/main.dart' as app;

int screenCounter = 1;
late Finder fab;

void main() {
  group('automatic_tests', () {
    testWidgets('Run app and click greeting', (WidgetTester tester) async {
      final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      await tester.runAsync(() async {
        app.main();
        await tester.pumpAndSettle();
        await oneCallKey(
            ConstantScreens.mainMenuScreen, 1, false, tester, binding, "Linux");
        await tester.pumpAndSettle();
        await oneCallKey("HelloWorld", 1, false, tester, binding, "Linux");
      });
    });
  });
}

Future<void> createScreenshot(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  String platformName,
) async {
  await tester.pumpAndSettle();
  await binding.takeScreenshot('$platformName/$screenCounter');
  screenCounter += 1;
}

Future<void> oneCallText(
  String searchedPattern,
  int sleepTime,
  bool takeScreen,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  String platformName,
) async {
  await tester.pumpAndSettle();
  fab = find.text(searchedPattern).last;
  await tester.pumpAndSettle();
  await tester.tap(fab);
  if (takeScreen) {
    await createScreenshot(tester, binding, platformName);
  }
}

Future<void> oneCallKey(
  String searchedPattern,
  int sleepTime,
  bool takeScreen,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  String platformName,
) async {
  await tester.pumpAndSettle();
  fab = find.byKey(Key(searchedPattern));
  await tester.pump();
  await tester.tap(fab);
  if (takeScreen) {
    await createScreenshot(tester, binding, platformName);
  }
}

Future<void> pumpForSeconds(WidgetTester tester,
    {int milliseconds = 4000}) async {
  bool timerDone = false;
  Timer(Duration(milliseconds: milliseconds), () => timerDone = true);
  while (timerDone != true) {
    await tester.pump();
  }
}
