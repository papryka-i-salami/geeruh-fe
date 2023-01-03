import 'package:flutter/material.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_build_card.dart';
import 'package:geeruh/widgets/gee_priority_dropdown.dart';
import 'package:geeruh/widgets/gee_task_editor/gee_task_editor_store.dart';
import 'package:geeruh/widgets/gee_text_dropdown.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';

class GeeTaskEditor extends StatefulWidget {
  const GeeTaskEditor({
    super.key,
    required this.item,
    required this.boardStore,
  });

  final RichTextItem item;
  final BoardStore boardStore;

  @override
  StateWithLifecycle<GeeTaskEditor> createState() => _GeeTaskEditorState();
}

class _GeeTaskEditorState extends StateWithLifecycle<GeeTaskEditor> {
  final GeeTaskEditorStore _taskEditorStore = GeeTaskEditorStore();

  @override
  void preFirstBuildInit() {
    _taskEditorStore.init(context, widget.item.issue, widget.boardStore);
  }

  @override
  Widget build(BuildContext context) {
    double popupWidth = MediaQuery.of(context).size.width * 0.9;
    double popupHeight = MediaQuery.of(context).size.height * 0.8;
    return Container(
        width: popupWidth,
        height: popupHeight,
        decoration: BoxDecoration(
          color: GeeColors.gray10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                "${widget.item.issue.type}: ",
                style: GeeTextStyles.heading1.copyWith(color: GeeColors.gray2),
              ),
              Expanded(
                child: TextFormField(
                  onChanged: (newString) {
                    _taskEditorStore.summary = newString;
                  },
                  initialValue: widget.item.issue.summary,
                  decoration: InputDecoration.collapsed(
                    hintText: "Insert title",
                    hintStyle:
                        GeeTextStyles.heading2.copyWith(color: GeeColors.gray6),
                  ),
                  style:
                      GeeTextStyles.heading1.copyWith(color: GeeColors.gray2),
                ),
              ),
            ],
          ),
          Container(
              color: GeeColors.secondary1, width: popupWidth * 0.5, height: 3),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Priority"),
                          GeePriorityDropdown()
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.item.issue.issueId != "")
                            GeeTextDropdown(
                              items:
                                  widget.boardStore.getIssueIdsWithEmptyOne(),
                              initialValue:
                                  widget.item.issue.assigneeUserId != null
                                      ? widget.boardStore.getUserNameAndSurname(
                                          widget.item.issue.assigneeUserId!)
                                      : "Empty",
                              onChanged: (selectedPerson) {
                                widget.boardStore.setAssignee(selectedPerson);
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _taskContributors(popupWidth * 0.25),
                        const SizedBox(width: 15),
                        _taskActivity(popupWidth * 0.35)
                      ],
                    ),
                  ),
                ]),
                const SizedBox(width: 15),
                _taskDescription(
                    widget.item.issue.description ?? "", popupWidth * 0.35),
              ],
            ),
          ),
        ]));
  }

  Widget _taskDescription(String description, double width) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: GeeColors.gray1, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: GeeColors.white,
      ),
      width: width,
      child: Column(children: [
        Text(
          "Task description",
          style: GeeTextStyles.heading2.copyWith(color: GeeColors.secondary1),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (newString) {
                    _taskEditorStore.description = newString;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: widget.item.issue.description,
                  style: GeeTextStyles.paragraph2,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _taskActivity(double width) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: GeeColors.gray1, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: GeeColors.white,
      ),
      width: width,
      child: Column(children: [
        Text(
          "Activity",
          style: GeeTextStyles.heading2.copyWith(color: GeeColors.secondary1),
        ),
        const SizedBox(height: 10),
        const Text(
          "",
          style: GeeTextStyles.paragraph3,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        )
      ]),
    );
  }

  Widget _taskContributors(double width) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: GeeColors.gray1, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: GeeColors.white,
      ),
      width: width,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Assignee",
                  style: GeeTextStyles.heading2
                      .copyWith(color: GeeColors.secondary1),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.item.issue.issueId != "")
                      GeeTextDropdown(
                        items: widget.boardStore.getUsersNamesWithEmptyOne(),
                        initialValue: widget.item.issue.assigneeUserId != null
                            ? widget.boardStore.getUserNameAndSurname(
                                widget.item.issue.assigneeUserId!)
                            : "Empty",
                        onChanged: (selectedPerson) {
                          widget.boardStore.setAssignee(selectedPerson);
                        },
                      ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _approveButton(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _approveButton() {
    String userId = "";
    return geeUniversalButton(200, 100, () async {
      widget.item.id == ""
          ? await _taskEditorStore.postIssue(context)
          : {
              userId =
                  widget.boardStore.getUserIdByName(widget.boardStore.assignee),
              await _taskEditorStore.updateIssue(
                  context, widget.item.id, userId)
            };
    }, "Approve");
  }
}
