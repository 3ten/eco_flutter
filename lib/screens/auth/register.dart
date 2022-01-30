import 'package:eco/providers/user_provider.dart';
import 'package:eco/screens/auth/login.dart';
import 'package:eco/widgets/city_picker.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dealController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    dealController.dispose();
    cityController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

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
                   TextInput(
                    controller: emailController,
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   TextInput(controller: nameController,label: 'ФИО'),
                  const SizedBox(
                    height: 10,
                  ),
                   TextInput(controller: dealController,label: 'Вид деятельности'),
                  const SizedBox(
                    height: 10,
                  ),
                  CityPicker(controller: cityController, setCity: (_) {
                    cityController.text = _;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                   TextInput(controller: passwordController,label: 'Пароль'),
                  const SizedBox(
                    height: 10,
                  ),
                   TextInput(controller: repeatPasswordController,label: 'Повторите пароль'),
                  Expanded(child: Container()),
                  ElevatedButton(
                      onPressed: () {
                        context.read<UserProvider>().register(
                          username: emailController.text,
                          password: passwordController.text,
                          busyness: dealController.text,
                          name: nameController.text,
                          city: cityController.text,
                        );
                      },
                      child: const Text('Зарегистрироваться'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
