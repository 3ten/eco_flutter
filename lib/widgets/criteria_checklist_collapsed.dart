import 'package:eco/models/checklist_model.dart';
import 'package:eco/providers/checklist_provider.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'back_dialog.dart';

class CriteriaChecklistCollapsed extends StatefulWidget {
  const CriteriaChecklistCollapsed({
    Key? key,
  }) : super(key: key);

  @override
  _CriteriaChecklistCollapsedState createState() =>
      _CriteriaChecklistCollapsedState();
}

class _CriteriaChecklistCollapsedState
    extends State<CriteriaChecklistCollapsed> {
  @override
  void initState() {
    // fetch();

    super.initState();

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => context
        .read<CheckListProvider>()
        .setOldAndCheck(context.read<ReportProvider>().report));

  }

  fetch() {
    final checklist = context.read<CheckListProvider>();
    checklist.getChecklistCriteria();
  }

  setCriteria() {
    print('element');
    final checklist = context.read<CheckListProvider>().checklistCriteria;
    for (var obj in checklist) {
      for (var element in obj.boxes) {
        if (element.isSelected) {
          print(element.label);
          context.read<ReportProvider>().addCriteria(element.label);
        } else {
          context.read<ReportProvider>().removeCriteria(element.label);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final checklist = context.watch<CheckListProvider>();
    return WillPopScope(
      onWillPop: () async {
        bool? dialog = await showDialog(
          context: context,
          builder: (context) => const BackDialog(),
        );
        print('dfsff');
        if (dialog == null) return false;
        if (dialog) {
          setCriteria();
        } else {
          checklist.reset();
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Добавить критерии'),
        ),
        body: ListView(
          children: [
            for (var i = 0; i < checklist.checklistCriteria.length; i++)
              ExpandableNotifier(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: <Widget>[
                      ScrollOnExpand(
                        scrollOnExpand: true,
                        scrollOnCollapse: false,
                        child: ExpandablePanel(
                          theme: const ExpandableThemeData(
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                          ),
                          header: Row(
                            children: [
                              Checkbox(
                                value:
                                    checklist.checklistCriteria[i].isSelected,
                                onChanged: (bool? value) {

                                  context
                                      .read<CheckListProvider>()
                                      .selectCriteria(
                                          i: i, value: value ?? false);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  checklist.checklistCriteria[i].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          collapsed: Container(),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (var j = 0;
                                  j <
                                      checklist
                                          .checklistCriteria[i].boxes.length;
                                  j++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(checklist
                                        .checklistCriteria[i].boxes[j].label),
                                    value: checklist.checklistCriteria[i]
                                        .boxes[j].isSelected,
                                    onChanged: (bool? value) {
                                      context
                                          .read<CheckListProvider>()
                                          .selectCriteria(
                                              i: i,
                                              j: j,
                                              value: value ?? false);
                                    },
                                  ),
                                ),
                            ],
                          ),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 10, bottom: 0),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme: const ExpandableThemeData(
                                    crossFadePoint: 0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setCriteria();
            Navigator.pop(context);
          },
          child: const Icon(Icons.done),
        ),
      ),
    );
  }
}
