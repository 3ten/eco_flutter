import 'package:eco/models/checklist_model.dart';
import 'package:eco/providers/checklist_provider.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/widgets/criteria_checklist_collapsed.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'image_picker_button.dart';

class CriteriaProjectCollapsed extends StatefulWidget {
  const CriteriaProjectCollapsed({Key? key}) : super(key: key);

  @override
  _CriteriaProjectCollapsedState createState() =>
      _CriteriaProjectCollapsedState();
}

class _CriteriaProjectCollapsedState extends State<CriteriaProjectCollapsed> {
  @override
  Widget build(BuildContext context) {
    final criteria = context.watch<ReportProvider>().project.criteria;
    final _report = context.watch<ReportProvider>().project;
    return Column(children: [
      for (var i = 0; i < (criteria?.length ?? 0); i++)
        ExpandableNotifier(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                  ),
                  header: Row(
                    children: [
                      Flexible(
                        child: Text(
                          criteria![i].name ?? "",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                      Container(margin: const EdgeInsets.only(left: 10,right: 5),child: Text(criteria[i].rating?.toStringAsFixed(1) ?? "0.0")),
                      Container(

                        child: SvgPicture.asset(
                          'assets/icons/star.svg',
                        ),
                      ),
                    ],
                  ),
                  collapsed: Container(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var item in criteria[i].images ?? [])
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
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
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 0),
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
    ]);
  }
}
