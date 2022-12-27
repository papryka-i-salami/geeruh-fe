import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_popup.dart';
import 'package:geeruh/widgets/gee_priority_dropdown.dart';
import 'package:geeruh/widgets/gee_task_editor/gee_task_editor.dart';

Widget buildCard(AppFlowyGroupItem item) {
  if (item is RichTextItem) {
    return _GeeBuildCard(item: item);
  }

  throw UnimplementedError();
}

class _GeeBuildCard extends StatefulWidget {
  final RichTextItem item;
  const _GeeBuildCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<_GeeBuildCard> createState() => _GeeBuildCardState();
}

class _GeeBuildCardState extends State<_GeeBuildCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.title,
                  style: GeeTextStyles.paragraph2,
                  textAlign: TextAlign.left,
                ),
                _editButton(widget.item),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 16,
                    width: 16,
                    child: FittedBox(
                      // alignment: Alignment.bottomCenter,
                      fit: BoxFit.fill,
                      child: priorityImages[widget.item.priority],
                      // child:
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    maxLines: 3,
                    widget.item.description,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: GeeTextStyles.paragraph3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.item.code,
                  style: GeeTextStyles.paragraph3,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _editButton(RichTextItem item) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Image.asset(
          "images/EditPencil.png",
          width: 24,
          height: 24,
          color: GeeColors.secondary2,
        ),
        onTap: () =>
            GeePopup(context, content: GeeTaskEditor(item: item)).show(),
      ),
    );
  }
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String description;
  final Priority priority;
  final String code;

  RichTextItem({
    required this.title,
    required this.description,
    required this.priority,
    required this.code,
  });

  @override
  String get id => title;
}
