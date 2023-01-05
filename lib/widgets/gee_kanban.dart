import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_build_card.dart';

class GeeKanban extends StatefulWidget {
  final List<AppFlowyGroupData> groups;
  final BoardStore boardStore;
  const GeeKanban({
    Key? key,
    required this.groups,
    required this.boardStore,
  }) : super(key: key);

  @override
  State<GeeKanban> createState() => _GeeKanbanState();
}

class _GeeKanbanState extends State<GeeKanban> {
  late AppFlowyBoardController controller;

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    boardController = AppFlowyBoardScrollController();
    controller = AppFlowyBoardController(
      // DO NOT REMOVE
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
      onMoveGroupItem: (groupId, fromIndex, toIndex) {},
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        // TODO when moved between groups it resets order (because of getIssues)
        var fromGroup =
            widget.groups.firstWhere((group) => group.id == fromGroupId);

        var toGroup =
            widget.groups.firstWhere((group) => group.id == toGroupId);

        String issueId = toGroup.items.isNotEmpty
            ? toGroup.items.elementAt(toIndex).id
            : fromGroup.items.elementAt(fromIndex).id;
        widget.boardStore.updateIssueStatus(context, issueId, toGroupId);
        widget.boardStore.getIssues(context);
      },
    );
    controller.addGroups(widget.groups);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.clear();
    controller.addGroups(widget.groups);
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
              border: Border.all(color: GeeColors.gray1),
              color: GeeColors.white),
          child: buildCard(groupItem, widget.boardStore),
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
                      color: _colorFromId(
                        columnData.id,
                      ),
                      width: 3))),
          child: AppFlowyGroupHeader(
            title: SizedBox(
              child: Text(
                columnData.headerData.groupName,
                overflow: TextOverflow.clip,
                style: GeeTextStyles.heading5.copyWith(
                  color: _colorFromId(
                    columnData.id,
                  ),
                ),
              ),
            ),
            height: 50,
            margin: config.groupItemPadding,
          ),
        ),
        groupConstraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width /
                (widget.groups.length + 0.05 * widget.groups.length)),
        config: config,
      ),
    );
  }

  Color _colorFromId(String id) {
    int orderNumber = widget.boardStore.statuses
        .lastIndexWhere((status) => status.code == id);
    int numOfStatuses = widget.boardStore.statuses.length;
    double minSaturation = HSVColor.fromColor(GeeColors.secondary3).saturation;
    double maxSaturation = HSVColor.fromColor(GeeColors.secondary1).saturation;
    double saturationStep = (minSaturation - maxSaturation) / numOfStatuses;
    double minValue = HSVColor.fromColor(GeeColors.secondary1).value;
    double maxValue = HSVColor.fromColor(GeeColors.secondary3).value;
    double valueStep = (maxValue - minValue) / numOfStatuses;
    Color color = GeeColors.svModify(
        color: GeeColors.secondary1,
        s: maxSaturation + saturationStep * (orderNumber - 1),
        v: minValue + valueStep * (orderNumber - 1));
    return color;
  }
}
