import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

Widget geeTitleList(double width, double heigth, List<Widget> entries,
    [String title = '', String? imagePath, Color? color]) {
  return Column(
    children: [
      Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            color: GeeColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
            border: Border.all(color: color ?? GeeColors.gray1)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagePath != null
                  ? Image.asset(imagePath, width: 40, height: 40)
                  : const SizedBox(),
              const SizedBox(width: 20),
              Text(
                title,
                style: GeeTextStyles.heading5,
              ),
            ],
          ),
        ),
      ),
      Container(
        width: width,
        height: heigth - 50,
        decoration: BoxDecoration(
            color: GeeColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(color: GeeColors.gray1)),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: entries[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    ],
  );
}
