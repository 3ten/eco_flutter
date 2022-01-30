import 'package:eco/models/report_model.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/city_picker.dart';
import 'package:eco/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  static const route = '/project';

  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String? city;
  DateTime? date;
  int? rating;

  String getRating(ReportModel item) {
    if (item.criteria == null) return "0.0";
    num ratingSum = item.criteria
            ?.fold(0, (num? sum, value) => (sum ?? 0) + (value.rating ?? 0)) ??
        0;
    return (ratingSum / (item.criteria?.length ?? 1)).toStringAsFixed(1);
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<DateTime?> showCalendar(context) async => showDatePicker(
        helpText: 'Выберете дату',
        context: context,
        locale: const Locale('ru', 'RU'),
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );

  setRating(int? value, BuildContext context) {
    setState(() {
      rating = value;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() {
    context.read<ReportProvider>().getProjects();
  }

  List<ReportModel> _filterProjects(List<ReportModel> projects) {
    return projects.where((el) {
      var flag = true;
      if (city != null) {
        if (el.city != city) flag = false;
      }
      if (date != null && el.dateStart != null && el.dateEnd != null) {
        if (el.dateStart!.isBefore(date!) && el.dateEnd!.isAfter(date!))
          flag = false;
      }
      if (rating != null) {
        print(el.rating);
        if (num.parse(getRating(el)) <= (rating ?? 1)) flag = false;
      }
      return flag;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = context.watch<ReportProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Проекты')),
      body: RefreshIndicator(
        onRefresh: () async {
          fetch();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CitySelect(
                            setCity: (value) {
                              setState(() {
                                city = value;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(city == null ? 'Город' : 'г. $city'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showCalendar(context).then((value) {
                        if (value == null) return;
                        setState(() {
                          date = value;
                        });
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(date == null ? 'Дата' : _formatDate(date)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Выберите рейтинг'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () => setRating(null, context),
                                    child: const ListTile(
                                      title:  Text("Сбросить"),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => setRating(1, context),
                                    child: const ListTile(
                                      title:  Text(">1"),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () => setRating(2, context),
                                    title: const Text(">2"),
                                  ),
                                  ListTile(
                                    onTap: () => setRating(3, context),
                                    title: const Text(">3"),
                                  ),
                                  ListTile(
                                    onTap: () => setRating(4, context),
                                    title: const Text(">4"),
                                  ),
                                  ListTile(
                                    onTap: () => setRating(5, context),
                                    title: const Text("=5"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('Рейтинг ' +
                            (rating == null ? "" : rating.toString())),
                      ),
                    ),
                  )
                ],
              ),
            ),
            for (var item in _filterProjects(reportProvider.projects))
              ProjectCard(
                onTap: () {
                  context.read<ReportProvider>().setProject(item);
                  Navigator.pushNamed(context, '/project/info');
                },
                item: item,
              )
          ],
        ),
      ),
    );
  }
}
