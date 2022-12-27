import 'dart:math';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_build_card.dart';
import 'package:geeruh/widgets/gee_kanban.dart';
import 'package:geeruh/widgets/gee_priority_dropdown.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  StateWithLifecycle<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends StateWithLifecycle<BoardScreen> {
  final BoardStore _boardStore = BoardStore();

  @override
  void preFirstBuildInit() {
    _boardStore.init(context);
  }

  final group1 = AppFlowyGroupData(id: "Backlog", name: "Backlog", items: [
    RichTextItem(
        title: "Task Alpha",
        description: randomString(),
        priority: Priority.high,
        code: "T-1"),
    RichTextItem(
        title: "Task Bravo",
        description: randomString(),
        priority: Priority.low,
        code: "T-2"),
    RichTextItem(
        title: "Task Charlie",
        description: randomString(),
        priority: Priority.medium,
        code: "T-3"),
    RichTextItem(
        title: "Task Delta",
        description: randomString(),
        priority: Priority.top,
        code: "T-4"),
    RichTextItem(
        title: "Task Echo",
        description: randomString(),
        priority: Priority.high,
        code: "T-5"),
    RichTextItem(
        title: "Task Foxtrot",
        description: randomString(),
        priority: Priority.medium,
        code: "T-6"),
    RichTextItem(
        title: "Task Golf",
        description: randomString(),
        priority: Priority.low,
        code: "T-7"),
    RichTextItem(
        title: "Task Hotel",
        description: randomString(),
        priority: Priority.medium,
        code: "T-8"),
    RichTextItem(
        title: "Task India",
        description: randomString(),
        priority: Priority.high,
        code: "T-9"),
  ]);

  final group2 = AppFlowyGroupData(
    id: "Selected For Development",
    name: "Selected For Development",
    items: <AppFlowyGroupItem>[
      RichTextItem(
          title: "Task Juliet",
          description: randomString(),
          priority: Priority.low,
          code: "T-10"),
      RichTextItem(
          title: "Task Kilo",
          description: randomString(),
          priority: Priority.high,
          code: "T-11"),
    ],
  );

  final group3 = AppFlowyGroupData(
      id: "In progress", name: "In progress", items: <AppFlowyGroupItem>[]);
  final group4 = AppFlowyGroupData(
      id: "Awaiting review",
      name: "Awaiting review",
      items: <AppFlowyGroupItem>[]);
  final group5 =
      AppFlowyGroupData(id: "Done", name: "Done", items: <AppFlowyGroupItem>[]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Board Screen"),
      ),
      body: Scaffold(
        body: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: GeeColors.gray1,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: GeeColors.gray1)),
            child: GeeKanban(groups: [group1, group2, group3, group4, group5])),
      ),
    );
  }
}

String randomString() {
  var a = Random().nextInt(loremIpsum.length);
  var b = Random().nextInt(loremIpsum.length);

  return loremIpsum.substring(min(a, b), max(a, b));
}

const String loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in ullamcorper arcu. Donec tempor, enim eget mollis tempor, urna nunc pulvinar nisl, ac varius magna nibh quis odio. Donec ultricies ligula in eleifend sodales. Nam quis eros sit amet metus aliquet cursus a euismod lacus. Aliquam viverra euismod ligula ac fermentum. Aliquam pharetra est ac elit bibendum, sit amet suscipit massa volutpat. Integer eget neque libero. Donec tempor efficitur risus. Suspendisse condimentum volutpat fringilla. Cras blandit lectus odio, vitae pellentesque mi aliquet vel. Duis semper iaculis purus, vulputate bibendum augue pellentesque eu. In hac habitasse platea dictumst. Praesent venenatis faucibus aliquam. Vestibulum ac lacinia ipsum. Mauris vel nulla sed tellus tempus aliquet. Proin ornare neque vitae sem sollicitudin, eu aliquet lacus fringilla. Cras viverra lacus justo, ut tincidunt justo mattis sit amet. Phasellus fringilla lectus non nisi ultrices, vel elementum urna vulputate. Vivamus semper, lorem non suscipit eleifend, urna nisi venenatis dui, a congue metus lorem vitae augue. Duis convallis est nec placerat tincidunt. Phasellus tempus ante ac dapibus tincidunt. Nullam est urna, imperdiet nec molestie iaculis, malesuada quis orci. Aliquam cursus bibendum nibh nec bibendum. Donec eros justo, convallis sit amet nunc nec, posuere ultricies leo. Praesent laoreet volutpat augue sit amet tristique. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. ";
