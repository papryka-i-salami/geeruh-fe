import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

Widget universalButton(double width, double heigth, Function onPressed,
    [String caption = 'Button']) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, heigth),
      backgroundColor: GeeColors.primary1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    key: Key(caption),
    onPressed: () {
      onPressed();
    },
    child: Text(caption, style: GeeTextStyles.heading6),
  );
}
