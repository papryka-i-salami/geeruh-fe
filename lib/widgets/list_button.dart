import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

Widget listButton(Function onPressed, [String caption = 'List Entry']) {
  return TextButton(
    style: TextButton.styleFrom(
      minimumSize: const Size(double.infinity, double.infinity),
      foregroundColor: GeeColors.gray1,
    ),
    key: Key(caption),
    onPressed: () {
      onPressed();
    },
    child: Text(caption, style: GeeTextStyles.heading6),
  );
}
