import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

Widget geeAvatar(int? id, String? name, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      border: Border.all(color: GeeColors.gray2, width: 1),
      color: id != null
          ? HSVColor.fromAHSV(0.9, id * 19 % 360, 1, 1).toColor()
          : GeeColors.gray10,
      borderRadius: BorderRadius.circular(size),
    ),
    child: Center(
      child: Text(
        name == null ? "" : name.toUpperCase()[0],
        style: TextStyle(color: GeeColors.white, fontSize: size / 3),
      ),
    ),
  );
}
