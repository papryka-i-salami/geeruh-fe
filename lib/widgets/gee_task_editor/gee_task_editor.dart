import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/combine_statuses.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_build_card.dart';
import 'package:geeruh/widgets/gee_future_child.dart';
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
    // TODO allow new task to be created
    IssueRes currentIssue = widget.item.issue.issueId == ""
        ? widget.item.issue
        : widget.boardStore.getIssueById(widget.item.issue.issueId);
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
              currentIssue.issueId.isNotEmpty
                  ? Text(
                      "${currentIssue.issueId}: ",
                      style: GeeTextStyles.heading1
                          .copyWith(color: GeeColors.gray2),
                    )
                  : const SizedBox(),
              Expanded(
                child: TextFormField(
                  onChanged: (newString) {
                    _taskEditorStore.summary = newString;
                  },
                  initialValue: currentIssue.summary,
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
                          Text(
                            currentIssue.type,
                            style: GeeTextStyles.heading4
                                .copyWith(color: GeeColors.secondary1),
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
                        _taskContributorsAndRelatedIssues(
                            popupWidth * 0.25, currentIssue),
                        const SizedBox(width: 15),
                        _taskActivity(popupWidth * 0.35)
                      ],
                    ),
                  ),
                ]),
                const SizedBox(width: 15),
                _taskDescription(currentIssue.description ?? "",
                    popupWidth * 0.35, currentIssue),
              ],
            ),
          ),
        ]));
  }

  Widget _taskDescription(
      String description, double width, IssueRes currentIssue) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: GeeColors.gray1, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: GeeColors.white,
      ),
      width: width,
      child: Column(
        children: [
          Text(
            "Task description:",
            style: GeeTextStyles.heading2.copyWith(color: GeeColors.secondary1),
          ),
          const SizedBox(height: 10),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (newString) {
                      _taskEditorStore.description = newString;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    initialValue: currentIssue.description,
                    style: GeeTextStyles.paragraph2,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          currentIssue.issueId == ""
              ? Row()
              : Text(
                  "Comments:",
                  style: GeeTextStyles.heading2
                      .copyWith(color: GeeColors.secondary1),
                ),
          const SizedBox(height: 10),
          currentIssue.issueId == ""
              ? Row()
              : Observer(
                  builder: (_) => GeeFutureChild(
                    loaded: () => commentsWidget(),
                    status: combineStatuses(
                      [
                        widget.boardStore.futureGetComments.status,
                        widget.boardStore.futurePostComment.status,
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget listViewForComments(IssueRes currentIssue) {
    IssueRes currentIssue = widget.item.issue.issueId == ""
        ? widget.item.issue
        : widget.boardStore.getIssueById(widget.item.issue.issueId);

    List<CommentRes> issueComments = widget.boardStore.comments
        .where((comment) => comment.issueId == currentIssue.issueId)
        .toList();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: GeeColors.gray1, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: GeeColors.white,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: issueComments.map(
          (issueComment) {
            String personName = widget.boardStore
                .getUserNameAndSurname(issueComment.creatorUserId);
            return Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: GeeTextStyles.paragraph2
                        .copyWith(color: GeeColors.secondary1),
                    children: <TextSpan>[
                      const TextSpan(text: "\u2022 "),
                      TextSpan(
                        text: "$personName: ",
                        style: GeeTextStyles.paragraph2.copyWith(
                            color: GeeColors.secondary1,
                            fontWeight: FontWeight.bold),
                      ),
                      // ignore: unnecessary_string_interpolations
                      TextSpan(text: "${issueComment.content}"),
                    ],
                  ),
                ),
                if (issueComment.creatorUserId ==
                    widget.boardStore.currentUser!.userId)
                  IconButton(
                    icon: Icon(Icons.delete, size: 25, color: GeeColors.red),
                    onPressed: () {
                      widget.boardStore
                          .deleteComment(context, issueComment.commentId);
                    },
                  ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }

  Widget commentsWidget() {
    IssueRes currentIssue = widget.item.issue.issueId == ""
        ? widget.item.issue
        : widget.boardStore.getIssueById(widget.item.issue.issueId);
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: listViewForComments(currentIssue),
          ),
          SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (newComment) {
                      widget.boardStore.newComment = newComment;
                    },
                    keyboardType: TextInputType.multiline,
                    style: GeeTextStyles.paragraph2,
                    textAlign: TextAlign.start,
                    minLines: 1,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(width: 20),
                geeUniversalButton(50, 50, () async {
                  {
                    if (widget.boardStore.newComment != "" &&
                        widget.boardStore.newComment != null) {
                      widget.boardStore
                          .postComment(context, currentIssue.issueId);
                    }
                    widget.boardStore.newComment = "";
                  }
                }, "Send"),
              ],
            ),
          ),
        ],
      ),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            "Activity:",
            style: GeeTextStyles.heading2.copyWith(color: GeeColors.secondary1),
          ),
        ),
        const SizedBox(height: 10),
        Observer(
          builder: (_) => GeeFutureChild(
            status: _taskEditorStore.futureGetIssueHistory.status,
            loaded: () {
              return
                  _taskEditorStore.issueHistory == null
                      ? const Text("")
                      : _editHistoryListView(_taskEditorStore.issueHistory!);
            },
          ),
        ),
      ]),
    );
  }

  Widget _editHistoryListView(List<IssueHistoryRes> entries) {
    List<RichText> historyRichTextEntries = [];

    entries.asMap().forEach((idx, entry) {
      if (entry.type == "INSERT") {
        historyRichTextEntries.add(_activityEntry(
            entry, "Created issue ", "\"${entry.historicIssue.summary}\" "));
      } else if (entry.type == "UPDATE") {
        if (entry.historicIssue.assigneeUserId !=
            entries[idx - 1].historicIssue.assigneeUserId) {
          if (entry.historicIssue.assigneeUserId == null) {
            var user = _taskEditorStore.boardStoreToGet!.users.firstWhereOrNull(
                (user) =>
                    user.userId ==
                    entries[idx - 1].historicIssue.assigneeUserId);
            historyRichTextEntries.add(_activityEntry(
                entry,
                "Removed assignee: ",
                user != null
                    ? "${user.firstName} ${user.surname}"
                    : "Unknown"));
          } else {
            var user = _taskEditorStore.boardStoreToGet!.users.firstWhereOrNull(
                (user) => user.userId == entry.historicIssue.assigneeUserId);
            historyRichTextEntries.add(
              _activityEntry(
                  entry,
                  "Changed assignee to: ",
                  user != null
                      ? "${user.firstName} ${user.surname}"
                      : "Unknown"),
            );
          }
        }
        if (entry.historicIssue.description !=
            entries[idx - 1].historicIssue.description) {
          if (entry.historicIssue.description == null ||
              entry.historicIssue.description!.isEmpty) {
            historyRichTextEntries.add(_activityEntry(
                entry,
                "Removed description: ",
                entries[idx - 1].historicIssue.description!));
          } else {
            historyRichTextEntries.add(_activityEntry(entry,
                "Updated description to: ", entry.historicIssue.description!));
          }
        }
        if (!const ListEquality().equals(entry.historicIssue.relatedIssues,
            entries[idx - 1].historicIssue.relatedIssues)) {
          historyRichTextEntries.add(_activityEntry(
              entry,
              "Changed parent issues to: ",
              entry.historicIssue.relatedIssues.toString()));
        }
        if (!const ListEquality().equals(
            entry.historicIssue.relatedIssuesChildren,
            entries[idx - 1].historicIssue.relatedIssuesChildren)) {
          historyRichTextEntries.add(_activityEntry(
              entry,
              "Changed child issues to: ",
              entry.historicIssue.relatedIssuesChildren.toString()));
        }
        if (entry.historicIssue.statusCode !=
            entries[idx - 1].historicIssue.statusCode) {
          String newStatus = _taskEditorStore.boardStoreToGet!.statuses
              .firstWhere((status) =>
                  status.code == entries[idx - 1].historicIssue.statusCode)
              .name;
          historyRichTextEntries
              .add(_activityEntry(entry, "Updated status to: ", newStatus));
        }
        if (entry.historicIssue.summary !=
            entries[idx - 1].historicIssue.summary) {
          historyRichTextEntries.add(_activityEntry(
              entry, "Updated summary to: ", entry.historicIssue.summary));
        }
      }
    });

    return Expanded(
      child: SingleChildScrollView(
        child: ListView(
            shrinkWrap: true,
            children: historyRichTextEntries.reversed.toList()),
      ),
    );
  }

  RichText _activityEntry(
      IssueHistoryRes entry, String description, String difference) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "[${_displayEditTime(DateTime.parse(entry.timestamp))}]\t",
          style: GeeTextStyles.heading6
              .copyWith(color: GeeColors.black, fontSize: 16)),
      TextSpan(
          text: description,
          style: GeeTextStyles.paragraph3.copyWith(color: GeeColors.black)),
      TextSpan(
          text: difference,
          style: GeeTextStyles.heading6
              .copyWith(color: GeeColors.primary1, fontSize: 14))
    ]));
  }

  String _displayEditTime(DateTime time) {
    return "${time.year}/${time.month}/${time.day} ${time.hour}:${time.minute}:${time.second}";
  }

  Widget _taskContributorsAndRelatedIssues(
      double width, IssueRes currentIssue) {
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
            child: currentIssue.issueId == ""
                ? Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: _approveButton(),
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Assignee:",
                        style: GeeTextStyles.heading2
                            .copyWith(color: GeeColors.secondary1),
                      ),
                      if (currentIssue.issueId != "")
                        GeeTextDropdown(
                          items: widget.boardStore.getUsersNamesWithEmptyOne(),
                          initialValue: currentIssue.assigneeUserId != null
                              ? widget.boardStore.getUserNameAndSurname(
                                  currentIssue.assigneeUserId!)
                              : "Empty",
                          onChanged: (selectedPerson) {
                            widget.boardStore.setAssignee(selectedPerson);
                          },
                        ),
                      const SizedBox(height: 15),
                      Text(
                        "Parent tasks:",
                        style: GeeTextStyles.heading2
                            .copyWith(color: GeeColors.secondary1),
                      ),
                      Observer(
                        builder: (_) => GeeFutureChild(
                          loaded: () => listViewWithDropdownParent(),
                          status: combineStatuses(
                            [
                              _taskEditorStore.futureMakeIssueRelation.status,
                              widget.boardStore.futureGetIssues.status,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      currentIssue.relatedIssuesChildren.isEmpty
                          ? Row()
                          : Text(
                              "Child tasks:",
                              style: GeeTextStyles.heading2
                                  .copyWith(color: GeeColors.secondary1),
                            ),
                      currentIssue.relatedIssuesChildren.isEmpty
                          ? Row()
                          : Observer(
                              builder: (_) => GeeFutureChild(
                                loaded: () => listViewWithoutDropdown(),
                                status: combineStatuses(
                                  [
                                    _taskEditorStore
                                        .futureMakeIssueRelation.status,
                                    widget.boardStore.futureGetIssues.status,
                                  ],
                                ),
                              ),
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
    String? userId;
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

  Widget listViewWithoutDropdown() {
    IssueRes currentIssue = widget.item.issue.issueId == ""
        ? widget.item.issue
        : widget.boardStore.getIssueById(widget.item.issue.issueId);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: currentIssue.relatedIssuesChildren
              .map(
                (parentIssue) => Row(
                  children: [
                    Text(
                      "\u2022 $parentIssue",
                      style: GeeTextStyles.paragraph2
                          .copyWith(color: GeeColors.secondary1),
                    ),
                    IconButton(
                      icon: Icon(
                          key: ValueKey(
                              "${parentIssue}_deleteParent"),
                          Icons.delete,
                          size: 25,
                          color: GeeColors.red),
                      onPressed: () {
                        _taskEditorStore.removeIssueRelation(
                            context, parentIssue, currentIssue.issueId);
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget listViewWithDropdownParent() {
    IssueRes currentIssue = widget.item.issue.issueId == ""
        ? widget.item.issue
        : widget.boardStore.getIssueById(widget.item.issue.issueId);
    return Observer(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: currentIssue.relatedIssues
                .map(
                  (parentIssue) => Row(
                    children: [
                      Text(
                        "\u2022 $parentIssue",
                        style: GeeTextStyles.paragraph2
                            .copyWith(color: GeeColors.secondary1),
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.delete, size: 25, color: GeeColors.red),
                        onPressed: () {
                          _taskEditorStore.removeIssueRelation(
                              context, currentIssue.issueId, parentIssue);
                        },
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GeeTextDropdown(
                key: const ValueKey("parentTaskDropdown"),
                items: widget.boardStore
                    .getIssuesWithoutSelectedOnes(currentIssue),
                initialValue: "Empty",
                onChanged: (selectedParentIssue) {
                  _taskEditorStore.selectParentIssue(selectedParentIssue);
                  if (_taskEditorStore.selectedParentIssue != "" &&
                      _taskEditorStore.selectedParentIssue != "Empty") {
                    _taskEditorStore.makeIssueRelation(
                        context,
                        currentIssue.issueId,
                        _taskEditorStore.selectedParentIssue);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
