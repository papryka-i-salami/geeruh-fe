import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geeruh/global_constants.dart';
import 'package:integration_test/integration_test.dart';
import 'package:geeruh/main.dart' as app;

String lorem =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla at rutrum sem. Morbi lectus augue, pulvinar at lectus nec, rutrum dictum arcu. Pellentesque aliquam malesuada libero, id laoreet erat faucibus non.";

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
            ConstantScreens.loginScreen, 1, false, tester, binding, "Linux");
        await oneCallKey("GeeruhLogo", 1, false, tester, binding, "Linux");
        final signUpFinder = find.text("Sign up");
        final loginFinder = find.text("Log in");
        expect(signUpFinder, findsOneWidget);
        expect(loginFinder, findsOneWidget);
        await tester.enterText(
            find.byKey(const ValueKey("LoginLoginTextField")), "user");
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(const ValueKey("LoginPasswordTextField")), "password");
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ElevatedButton, "Log in"));
        await tester.pumpAndSettle();
        final allProjectsFinder = find.text("My Projects");
        final allBoardsFinder = find.text("My Boards");
        expect(allProjectsFinder, findsOneWidget);
        expect(allBoardsFinder, findsOneWidget);
        await tester.tap(find.widgetWithText(ElevatedButton, "Add project"));
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(const ValueKey("ProjectCodeTextField")), "KODPROJEKTU");
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(const ValueKey("ProjectNameTextField")), "superprojekt");
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(const ValueKey("ProjectDescriptionTextField")), lorem);
        await tester.pumpAndSettle();
        // await tester.tap(find.widgetWithText(ElevatedButton, "Save"));
        await simulateKeyDownEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();
        await tester
            .tap(find.widgetWithText(TextButton, "Board for Test environment"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey("TEST-1_edit")).last);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey("parentTaskDropdown")));
        await tester.pumpAndSettle();
        await tester.tap(find.text("NIE-7").last);
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ElevatedButton, "Approve"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey("TEST-2_edit")).last);
        await tester.pumpAndSettle();
        // await tester.tap(find.byKey(const ValueKey("TEST-1_deleteParent")).last);
        // await tester.pumpAndSettle();
        // await tester.tap(find.widgetWithText(ElevatedButton, "Approve"));
        // await tester.pumpAndSettle();

        // final pencilFinder = find.image(FileImage(File('images/Team.png')));
        // expect(pencilFinder, findsOneWidget);
        // await tester.tap(find.widgetWithImage(IconButton, FileImage(file)));
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
