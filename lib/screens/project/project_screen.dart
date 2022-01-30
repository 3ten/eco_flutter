import 'package:eco/models/report_model.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/providers/user_provider.dart';
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
    final user = context.watch<UserProvider>();
    final reportProvider = context.watch<ReportProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Проекты')),
      body: RefreshIndicator(
        onRefresh: () async {
          fetch();
        },
        child: ListView(
          children: [
            for (var item in reportProvider.projects)
              ProjectCard(
                onTap: (){
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
