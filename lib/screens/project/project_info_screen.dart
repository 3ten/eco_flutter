import 'package:eco/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectInfoScreen extends StatelessWidget {
  static const route = '/project/info';

  const ProjectInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Проект №1')),
    );
  }
}
