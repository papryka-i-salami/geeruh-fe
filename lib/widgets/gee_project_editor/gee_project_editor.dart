import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_project_editor/gee_project_editor_store.dart';
import 'package:geeruh/screens/start/start_store.dart';

import 'package:geeruh/widgets/gee_future_child.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.width,
          height: widget.heigth,
          decoration: BoxDecoration(
              color: GeeColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: GeeColors.gray1)),
          child: Column(
            children: [
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
                child: Stack(
                  children: [
                    Center(
                        child: Text(
                            isNew
                                ? "New project"
                                : "Project code: ${widget.projectRes?.code}",
                            style: GeeTextStyles.heading5)),
                    isNew
                        ? const SizedBox(height: 0)
                        : Align(
                            alignment: const Alignment(0.95, 0),
                            child: //delete button
                                ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(120, 40),
                                backgroundColor: GeeColors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              key: const Key("delete"),
                              onPressed: () {
                                _projectEditorStore.deleteProject(context);
                              },
                              child: const Text("Delete",
                                  style: GeeTextStyles.heading6),
                            )),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      isNew
                          ? SizedBox(
                              // code
                              key: const ValueKey("ProjectCodeTextField"),
                              width: widget.width - 400,
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
                        key: const ValueKey("ProjectNameTextField"),
                        width: widget.width - 400,
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
                        // decribtion
                        key: const ValueKey("ProjectDescriptionTextField"),
                        width: widget.width - 400,
                        height:
                            isNew ? widget.heigth - 390 : widget.heigth - 300,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: ((widget.heigth - 300) / 20).round(),
                          maxLines: null,
                          onChanged: (newString) {
                            _projectEditorStore.description = newString;
                          },
                          initialValue:
                              isNew ? "" : widget.projectRes?.description,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Project description",
                            alignLabelWithHint: true,
                            hintText: "Enter project description",
                          ),
                        ),
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      //statuses
                      Container(
                        width: 300,
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
                            child: Text("Statuses:",
                                style: GeeTextStyles.heading5)),
                      ),
                      Container(
                        width: 300,
                        height: widget.heigth - 460,
                        decoration: BoxDecoration(
                            color: GeeColors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                            ),
                            border: Border.all(color: GeeColors.gray1)),
                        child: Observer(
                          builder: (_) => GeeFutureChild(
                            loaded: _loadedStatuses,
                            status:
                                _projectEditorStore.futureGetStatuses.status,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      !isNew
                          ? SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                onChanged: (newString) {
                                  _projectEditorStore.statusCode = newString;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "New status code",
                                  hintText: "Enter new status code",
                                ),
                              ),
                            )
                          : const SizedBox(height: 0),
                      const SizedBox(height: 20),
                      !isNew
                          ? SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                onChanged: (newString) {
                                  _projectEditorStore.statusName = newString;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "New status name",
                                  hintText: "Enter new status name",
                                ),
                              ),
                            )
                          : const SizedBox(height: 0),
                      const SizedBox(height: 20),
                      !isNew
                          ? SizedBox(
                              width: 300,
                              height: 50,
                              child: geeUniversalButton(
                                250,
                                50,
                                () {
                                  _projectEditorStore.postStatus(context);
                                },
                                "Add new status",
                              ),
                            )
                          : const SizedBox(height: 0),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _loadedStatuses() {
    return ListView.builder(
      itemCount: _projectEditorStore.statuses.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            const SizedBox(width: 20),
            Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                color: GeeColors.white,
                border: Border(
                  bottom: BorderSide(color: GeeColors.gray1, width: 1),
                ),
              ),
              child: Center(
                child: Text(
                  "${_projectEditorStore.statuses[index].name} (${_projectEditorStore.statuses[index].code.substring(_projectEditorStore.code!.length)})",
                  style: GeeTextStyles.paragraph2,
                ),
              ),
            ),
            // const SizedBox(width: 20),
            // IconButton(
            //   icon: const Icon(Icons.delete),
            //   onPressed: () {},
            // ),
          ],
        );
      },
    );
  }
}
