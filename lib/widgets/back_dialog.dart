import 'package:flutter/material.dart';

class BackDialog extends StatelessWidget {
  const BackDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Сохранить изменения?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Нет',
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Да'),
        ),
      ],
    );
  }
}
