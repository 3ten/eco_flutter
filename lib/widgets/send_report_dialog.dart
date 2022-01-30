import 'package:flutter/material.dart';

class SendReportDialog extends StatelessWidget {
  const SendReportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Вы хотите отправить?'),
      content: const Text('После отправки отчета вы не сможете его редактировать'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Отмена',
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Отправить'),
        ),
      ],
    );
  }
}
