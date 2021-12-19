import 'package:eco/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportInfoScreen extends StatelessWidget {
  static const route = '/report/info';

  const ReportInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Отчет №1')),
    );
  }
}
