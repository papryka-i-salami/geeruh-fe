import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/universal_button.dart';

Widget newProject(double width, double heigth) {
  return Column(
    children: [
      Container(
        width: width,
        height: heigth,
        decoration: BoxDecoration(
            color: GeeColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: GeeColors.gray1)),
        child: Column(children: [
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
                border: Border.all(color: GeeColors.gray1)),
            child: const Center(
                child: Text("New project", style: GeeTextStyles.heading5)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            // name
            width: width - 100,
            height: 70,
            child: TextField(
              onChanged: (newString) {
                // _loginStore.password = newString;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Project name",
                hintText: "Enter project name",
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            // decribtion
            width: width - 100,
            height: heigth - 300,
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: ((heigth - 300) / 20).round(),
              maxLines: null,
              onChanged: (newString) {
                // _loginStore.password = newString;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Project decribtion",
                alignLabelWithHint: true,
                hintText: "Enter project describtion",
              ),
            ),
          ),
          const SizedBox(height: 50),
          //save button
          universalButton(
            width - 100,
            50,
            () {},
            "Save",
          ),
        ]),
      ),
    ],
  );
}
