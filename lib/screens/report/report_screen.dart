import 'package:eco/models/report_model.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:eco/screens/auth/register.dart';
import 'package:eco/widgets/report_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  static const route = '/report';

  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    getMyReports();
  }

  getMyReports() {
    context.read<ReportProvider>().getReports();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final _report = context.watch<ReportProvider>();
    List<Widget> cards = [];
    for (var item in _report.reports) {
      cards.add(ReportCard(
        item: item,
        onTap: () {
          _report.setReportModel(item);
          Navigator.pushNamed(context, '/report/info');
        },
      ));
    }

    return !user.isAuth
        ? const RegisterScreen()
        : Scaffold(
            appBar: AppBar(title: const Text('Отчеты')),
            body: RefreshIndicator(
              onRefresh: () async {
                getMyReports();
              },
              child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: cards),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _report.setReportModel(ReportModel());
                Navigator.pushNamed(context, '/report/info');
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          );
  }
}
