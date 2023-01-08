import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geeruh/widgets/gee_avatar.dart';
import 'package:geeruh/widgets/gee_text_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('GeeAvatar has initial and color', (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr, child: geeAvatar(0, "Maks", 20)));
    final titleFinder = find.text("M");
    expect(
        ((tester.firstWidget(find.byType(Container)) as Container).decoration
                as BoxDecoration)
            .color,
        HSVColor.fromAHSV(1, 0, 1, 1).toColor());
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('GeeDropdown has "empty" default value', (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: MaterialApp(
            home: Material(
          child: GeeTextDropdown(
            items: ["Item 1", "Item 2", "Item 3"],
            initialValue: "Item 1",
            onChanged: () {},
          ),
        ))));
    final emptyFinder = find.text("Item 1");
    expect(emptyFinder, findsOneWidget);
  });
}
