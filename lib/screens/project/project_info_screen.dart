import 'package:eco/models/report_model.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/ProjectImage.dart';
import 'package:eco/widgets/criteria_collapsed.dart';
import 'package:eco/widgets/criteria_project_collapsed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectInfoScreen extends StatelessWidget {
  static const route = '/project/info';

  const ProjectInfoScreen({Key? key}) : super(key: key);

  String getRating(ReportModel item) {
    if (item.criteria == null) return "0.0";
    num ratingSum = item.criteria
            ?.fold(0, (num? sum, value) => (sum ?? 0) + (value.rating ?? 0)) ??
        0;
    return (ratingSum / (item.criteria?.length ?? 1)).toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final _project = context.watch<ReportProvider>().project;
    return Scaffold(
      appBar: AppBar(title: const Text('Проект')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_project.city ?? ""),
              Text(
                  "${_project.dateStart?.year.toString()}-${_project.dateStart?.month.toString().padLeft(2, '0')}-${_project.dateStart?.day.toString().padLeft(2, '0')}"),
              Text('Рейтинг  ' + getRating(_project))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var image in _project.description?.images ?? [])
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 100,
                      child: ProjectImage(
                        url: 'http://188.225.18.212/img/' + image,
                      ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const Text(
            "Описание мероприятия",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(_project.address ?? ""),
          const SizedBox(
            height: 5,
          ),
          Text(_project.description?.title ?? ""),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Оценка мероприятия",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          const CriteriaProjectCollapsed()
        ],
      ),
    );
  }
}
