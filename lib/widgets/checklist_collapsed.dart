import 'package:eco/models/checklist_model.dart';
import 'package:eco/providers/checklist_provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChecklistCollapsed extends StatefulWidget {
  const ChecklistCollapsed({Key? key, required this.item, required this.i})
      : super(key: key);
  final Checklist item;
  final int i;

  @override
  _ChecklistCollapsedState createState() => _ChecklistCollapsedState();
}

class _ChecklistCollapsedState extends State<ChecklistCollapsed> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                header: Row(
                  children: [
                    Checkbox(
                      value: widget.item.isSelected,
                      onChanged: (bool? value) {
                        context
                            .read<CheckListProvider>()
                            .select(i: widget.i, value: value ?? false);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.item.title,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                collapsed: Container(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var j = 0; j < widget.item.boxes.length; j++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(widget.item.boxes[j].label),
                          value: widget.item.boxes[j].isSelected,
                          onChanged: (bool? value) {
                            context.read<CheckListProvider>().select(
                                i: widget.i, j: j, value: value ?? false);
                          },
                        ),
                      ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 0, right: 10, bottom: 0),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
