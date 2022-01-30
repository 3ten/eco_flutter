import 'package:eco/models/report_model.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/city_picker.dart';
import 'package:eco/widgets/criteria_collapsed.dart';
import 'package:eco/widgets/description_collapsed.dart';
import 'package:eco/widgets/send_report_dialog.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportInfoScreen extends StatefulWidget {
  static const route = '/report/info';

  const ReportInfoScreen({Key? key}) : super(key: key);

  @override
  State<ReportInfoScreen> createState() => _ReportInfoScreenState();
}

class _ReportInfoScreenState extends State<ReportInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateStartController = TextEditingController();
  TextEditingController dateEndController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<DateTime?> showCalendar(context) async => showDatePicker(
        helpText: 'Выберете дату начала мероприятия',
        context: context,
        locale: const Locale('ru', 'RU'),
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    final report = context.read<ReportProvider>().report;
    nameController.text = report.name ?? "";
    dateStartController.text = _formatDate(report.dateStart);
    dateEndController.text = _formatDate(report.dateEnd);
    addressController.text = report.address ?? "";
    descriptionController.text = report.description?.title ?? "";
    cityController.text = report.city ?? "";
    super.initState();
  }
  Widget getStatus(ReportModel item) {
    if (item.status == 'check') {
      return const Text('Статус: на проверке',
          style:
          TextStyle(color: Color(0xFF5bc0de), fontWeight: FontWeight.bold));
    }
    if (item.status == 'rejected') {
      return const Text('Статус: отклонен',
          style:
          TextStyle(color: Color(0xFFd9534f), fontWeight: FontWeight.bold));
    }
    if (item.status == 'accepted') {
      return const Text('Статус: принят',
          style:
          TextStyle(color: Color(0xFF5cb85c), fontWeight: FontWeight.bold));
    }
    return Container();
  }


  @override
  Widget build(BuildContext context) {
    final _user = context.watch<UserProvider>();
    final _report = context.watch<ReportProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Отчет')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          TextInput(
            enabled: _report.report.status != 'draft' ? false : true,
            controller: nameController,
            onChanged: _report.setName,
            label: 'Название мероприятия',
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_report.report.status != 'draft') {
                      return;
                    }
                    showCalendar(context).then((DateTime? date) {
                      if (date != null) {
                        _report.setDateStart(date);
                        dateStartController.text =
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: TextInput(
                      enabled: _report.report.status != 'draft' ? false : true,
                      controller: dateStartController,
                      label: 'Дата начала',
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_report.report.status != 'draft') {
                      return;
                    }
                    showCalendar(context).then((DateTime? date) {
                      if (date != null) {
                        _report.setDateEnd(date);
                        dateEndController.text =
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: TextInput(
                      enabled: _report.report.status != 'draft' ? false : true,
                      controller: dateEndController,
                      label: 'Дата конца',
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          CityPicker(
            enabled: _report.report.status != 'draft' ? false : true,
            setCity: (city) {
              _report.setCity(city);
              cityController.text = city;
            },
            controller: cityController,
          ),
          const SizedBox(
            height: 14,
          ),
          TextInput(
            enabled: _report.report.status != 'draft' ? false : true,
            controller: addressController,
            onChanged: _report.setAddress,
            label: 'Адрес',
          ),
          const SizedBox(
            height: 14,
          ),
          DescriptionCollapsed(
            enabled: _report.report.status != 'draft' ? false : true,
            controller: descriptionController,
            onTitleChanged: _report.setDescriptionTitle,
            onPickImage: _report.setDescriptionImage,
          ),
          const SizedBox(
            height: 15,
          ),
          const CriteriaCollapsed(),
          const SizedBox(
            height: 15,
          ),
          if (_report.report.status == 'draft')
            ElevatedButton(
                onPressed: () async {
                  bool? dialog = await showDialog(
                    context: context,
                    builder: (context) => const SendReportDialog(),
                  );
                  if(dialog!=null && dialog == true){
                    context.read<ReportProvider>().updateStatus();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Отправить на проверку'))
          else
            getStatus(_report.report)
        ],
      ),
      floatingActionButton: _report.report.status == 'draft'
          ? FloatingActionButton(
              onPressed: () {
                _report.updateReport();
              },
              child: const Icon(Icons.save),
            )
          : null,
    );
  }
}
