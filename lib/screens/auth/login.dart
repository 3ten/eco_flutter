import 'package:eco/providers/report_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _userProvider = context.watch<UserProvider>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_userProvider.error != null)
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.redAccent, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Center(child: Text('Неверный пароль',style: TextStyle(color: Colors.redAccent),))),
            TextInput(
              controller: usernameController,
              label: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
            TextInput(controller: passwordController, label: 'Пароль'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await context.read<UserProvider>().login(
                      username: usernameController.text,
                      password: passwordController.text);
                  context.read<ReportProvider>().getReports();
                },
                child: const Text('Войти'))
          ],
        ),
      ),
    );
  }
}
