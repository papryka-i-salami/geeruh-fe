import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

class GeePopup {
  GeePopup(this.context, {required this.content, this.actions, this.title});
  BuildContext context;
  Widget content;
  List<Widget>? actions;
  Widget? title;

  Future<String?> show() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: title,
          content: content,
          actions: actions,
          backgroundColor: GeeColors.gray10,
        ),
      );
}
