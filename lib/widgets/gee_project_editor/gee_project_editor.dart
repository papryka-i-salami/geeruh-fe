import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_project_editor/gee_project_editor_store.dart';
import 'package:geeruh/screens/start/start_store.dart';

class GeeProjectEditor extends StatefulWidget {
  const GeeProjectEditor(
      {super.key,
      required this.width,
      required this.heigth,
      required this.startStore,
      this.projectRes});

  final double width;
  final double heigth;
  final StartStore startStore;
  final ProjectRes? projectRes;

  @override
  StateWithLifecycle<GeeProjectEditor> createState() =>
      _GeeProjectEditorState();
}

class _GeeProjectEditorState extends StateWithLifecycle<GeeProjectEditor> {
  final GeeProjectEditorStore _projectEditorStore = GeeProjectEditorStore();

  @override
  void preFirstBuildInit() {
    _projectEditorStore.init(context, widget.startStore, widget.projectRes);
  }

  bool get isNew => widget.projectRes == null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: widget.heigth,
          decoration: BoxDecoration(
              color: GeeColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: GeeColors.gray1)),
          child: Column(children: [
            Container(
              width: widget.width,
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
              child: Center(
                  child: Text(
                      isNew
                          ? "New project"
                          : "Project code: ${widget.projectRes?.code}",
                      style: GeeTextStyles.heading5)),
            ),
            const SizedBox(height: 20),
            isNew
                ? SizedBox(
                    // code
                    width: widget.width - 100,
                    height: 70,
                    child: TextField(
                      onChanged: (newString) {
                        _projectEditorStore.code = newString;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Project code",
                        hintText: "Enter project code",
                      ),
                    ),
                  )
                : const SizedBox(height: 0),
            SizedBox(height: isNew ? 20 : 0),
            SizedBox(
              // name
              width: widget.width - 100,
              height: 70,
              child: TextFormField(
                onChanged: (newString) {
                  _projectEditorStore.name = newString;
                },
                initialValue: isNew ? "" : widget.projectRes?.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Project name",
                  hintText: "Enter project name",
                  //fill text if isnt new
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              // description
              width: widget.width - 100,
              height: isNew ? widget.heigth - 390 : widget.heigth - 300,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: ((widget.heigth - 300) / 20).round(),
                maxLines: null,
                onChanged: (newString) {
                  _projectEditorStore.description = newString;
                },
                initialValue: isNew ? "" : widget.projectRes?.description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Project description",
                  alignLabelWithHint: true,
                  hintText: "Enter project description",
                ),
              ),
            ),
            const SizedBox(height: 50),
            //save button
            geeUniversalButton(
              widget.width - 100,
              50,
              () async {
                isNew
                    ? await _projectEditorStore.postProject(context)
                    : await _projectEditorStore.updateProject(context);
                setState(() {});
              },
              "Save",
            ),
          ]),
        ),
      ],
    );
  }
}
