import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextInput(
              label: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
            const TextInput(label: 'Пароль'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<UserProvider>().login();
                },
                child: const Text('Войти'))
          ],
        ),
      ),
    );
  }
}
