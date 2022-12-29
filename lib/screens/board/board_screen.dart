import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_build_card.dart';
import 'package:geeruh/widgets/gee_future_child.dart';
import 'package:geeruh/widgets/gee_kanban.dart';
import 'package:geeruh/widgets/gee_priority_dropdown.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  StateWithLifecycle<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends StateWithLifecycle<BoardScreen> {
  final BoardStore boardStore = BoardStore();

  @override
  void preFirstBuildInit() {
    boardStore.init(context);
  }

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
        body: Observer(
          builder: (_) => GeeFutureChild(
            loaded: _loaded,
            status: boardStore.futureGetIssues.status,
          ),
        ),
      ),
    );
  }

  Widget _loaded() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: GeeColors.gray1,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GeeColors.gray1)),
      child: GeeKanban(
        key: Key(boardStore.issues.hashCode.toString()),
        groups: [
          AppFlowyGroupData(
              id: "Backlog",
              name: "Backlog",
              items: boardStore.issues
                  .map((issue) =>
                      RichTextItem(issue: issue, priority: Priority.medium))
                  .toList()),
          AppFlowyGroupData(
              id: "Selected For Development",
              name: "Selected For Development",
              items: boardStore.issues
                  .map((issue) =>
                      RichTextItem(issue: issue, priority: Priority.medium))
                  .toList()),
          group3,
          group4,
          group5
        ],
        boardStore: boardStore,
      ),
    );
  }
}
