import 'package:eco/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckListScreen extends StatelessWidget {
  static const route = '/checklist';

  const CheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen')),
    );
  }
}
