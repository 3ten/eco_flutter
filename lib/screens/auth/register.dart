import 'package:eco/screens/auth/login.dart';
import 'package:eco/widgets/city_picker.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Авторизация'),
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('Вход')),
              Tab(icon: Text('Регистрация')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const LoginScreen(),
            Padding(
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
                  const TextInput(label: 'Вид деятельности'),
                  const SizedBox(
                    height: 10,
                  ),
                  CityPicker(setCity: (_){}),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextInput(label: 'Пароль'),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextInput(label: 'Повторите пароль'),
                Expanded(child: Container()),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Зарегистрироваться'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
