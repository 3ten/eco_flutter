import 'package:eco/models/checklist_model.dart';
import 'package:eco/providers/checklist_provider.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/widgets/criteria_checklist_collapsed.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_picker_button.dart';

class CriteriaCollapsed extends StatefulWidget {
  const CriteriaCollapsed({Key? key}) : super(key: key);

  @override
  _CriteriaCollapsedState createState() => _CriteriaCollapsedState();
}

class _CriteriaCollapsedState extends State<CriteriaCollapsed> {
  @override
  Widget build(BuildContext context) {
    final checklist = context.watch<CheckListProvider>();
    final criteria = context.watch<ReportProvider>().report.criteria;
    final _report = context.watch<ReportProvider>().report;
    return ExpandableNotifier(
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
                children: const [
                  Text(
                    "Критерии мероприятия",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (_report.status == 'draft')
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CriteriaChecklistCollapsed()),
                        );
                      },
                      child: const Text(
                        '+ Добавить критерии',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  for (var i = 0; i < (criteria?.length ?? 0); i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          criteria![i].name ?? "",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var item in criteria[i].images ?? [])
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'http://188.225.18.212/img/' + item,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              if (_report.status == 'draft')
                                ImagePickerButton(onPickImage: (image) {
                                  context
                                      .read<ReportProvider>()
                                      .setCriteriaImage(
                                          image, criteria[i].name ?? "");
                                }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
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
    );
  }
}
