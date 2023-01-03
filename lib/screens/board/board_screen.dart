import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/combine_statuses.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_build_card.dart';
import 'package:geeruh/widgets/gee_future_child.dart';
import 'package:geeruh/widgets/gee_kanban.dart';
import 'package:geeruh/widgets/gee_popup.dart';
import 'package:geeruh/widgets/gee_priority_dropdown.dart';
import 'package:geeruh/widgets/gee_task_editor/gee_task_editor.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  StateWithLifecycle<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends StateWithLifecycle<BoardScreen> {
  final BoardStore boardStore = BoardStore();
  List<AppFlowyGroupData> groups = [];
  List<AppFlowyGroupController> controllers = [];

  @override
  void preFirstBuildInit() async {
    await boardStore.init(context);
  }

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
            status: combineStatuses(
              [
                boardStore.futureGetStatuses.status,
                boardStore.futureGetIssues.status,
                boardStore.futureGetUsers.status,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loaded() {
    // TODO do it to only changed group (efficiency)
    groups = boardStore.statuses
        .map(
          (status) => AppFlowyGroupData(
            id: status.code,
            name: status.name,
            items: <AppFlowyGroupItem>[],
          ),
        )
        .toList();
    controllers.clear();
    for (var group in groups) {
      controllers.add(AppFlowyGroupController(groupData: group));
      boardStore.issues
          .where((issue) => issue.statusCode == group.id)
          .map((issue) => RichTextItem(issue: issue, priority: Priority.medium))
          .toList()
          .forEach((element) {
        controllers.last.add(element);
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: geeUniversalButton(100, 60, () {
            GeePopup(context,
                    content: GeeTaskEditor(
                        item: RichTextItem(
                            issue: IssueRes(
                                issueId: "", statusCode: "OPEN", type: "TASK"),
                            priority: Priority.medium),
                        boardStore: boardStore))
                .show();
          }, "Create task", 90),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: GeeColors.gray1,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: GeeColors.gray1)),
            child: GeeKanban(
              key: Key(boardStore.issues.hashCode.toString()),
              groups: groups,
              boardStore: boardStore,
            ),
          ),
        ),
      ],
    );
  }
}
