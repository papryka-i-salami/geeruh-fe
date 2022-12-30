import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

Widget geeUniversalButton(
  double width,
  double heigth,
  Function onPressed, [
  String caption = 'Button',
  double borderRadius = 5,
]) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, heigth),
      backgroundColor: GeeColors.primary1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    key: Key(caption),
    onPressed: () {
      onPressed();
    },
    child: Text(caption, style: GeeTextStyles.heading6),
  );
}
