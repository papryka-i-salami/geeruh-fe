import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

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
            Text(
              widget.item.title,
              style: GeeTextStyles.paragraph2,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 60),
                Flexible(
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

enum Priority {
  top,
  high,
  medium,
  low,
}
