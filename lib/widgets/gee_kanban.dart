import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_build_card.dart';

class GeeKanban extends StatefulWidget {
  final List<AppFlowyGroupData> groups;
  const GeeKanban({
    Key? key,
    required this.groups,
  }) : super(key: key);

  @override
  State<GeeKanban> createState() => _GeeKanbanState();
}

class _GeeKanbanState extends State<GeeKanban> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    // DO NOT REMOVE
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
    onMoveGroupItem: (groupId, fromIndex, toIndex) {},
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
  );

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    boardController = AppFlowyBoardScrollController();

    controller.addGroups(widget.groups);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupPadding: const EdgeInsets.symmetric(horizontal: 0.5),
      groupBackgroundColor: GeeColors.gray9,
      cornerRadius: 0.0,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: AppFlowyBoard(
          controller: controller,
          cardBuilder: (context, group, groupItem) => AppFlowyGroupCard(
                key: ValueKey(groupItem.id),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: GeeColors.gray1),
                    color: GeeColors.white),
                child: buildCard(groupItem),
              ),
          boardScrollController: boardController,
          // // DO NOT REMOVE
          // footerBuilder: (context, columnData) => AppFlowyGroupFooter(
          //       icon: const Icon(Icons.add, size: 20),
          //       title: const Text('New'),
          //       height: 50,
          //       margin: config.groupItemPadding,
          //       onAddButtonClick: () {
          //         boardController.scrollToBottom(columnData.id);
          //       },
          //     ),
          headerBuilder: (context, columnData) => Container(
                decoration: BoxDecoration(
                    color: GeeColors.gray10,
                    border: Border(
                        bottom: BorderSide(
                            color: _colorFromId(columnData.id), width: 3))),
                child: AppFlowyGroupHeader(
                  title: SizedBox(
                    width: 200,
                    child: Text(
                      columnData.headerData.groupName,
                      style: GeeTextStyles.heading5
                          .copyWith(color: _colorFromId(columnData.id)),
                    ),
                  ),
                  height: 50,
                  margin: config.groupItemPadding,
                ),
              ),
          groupConstraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width / 5.2),
          config: config),
    );
  }
}

Color _colorFromId(String id) {
  switch (id) {
    case "Backlog":
      return GeeColors.secondary1;
    case "Selected For Development":
      return GeeColors.secondary2;
    case "In progress":
      return GeeColors.secondary3;
    case "Awaiting review":
      return GeeColors.secondary4;
    case "Done":
      return GeeColors.secondary5;
    default:
      return GeeColors.secondary1;
  }
}
