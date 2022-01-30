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


  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() {
    context.read<ReportProvider>().getProjects();
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
                            setCity: (city) {
                              print(city);
                            },
                          ),
                        ),
                      );
                    },
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('г. Новосибирск'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('2001-10-12'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Рейтинг 5'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            for (var item in reportProvider.projects)
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
