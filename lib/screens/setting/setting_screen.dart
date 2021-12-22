import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/city_picker.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static const route = '/checklist';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    String city = '';
    // final user = context.watch<UserProvider>();
    return Listener(
      onPointerDown: (_) {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Настройки')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextInput(
                label: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                label: 'ФИО',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                label: 'Вид деятельности',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              CityPicker(
                controller: cityController,
                setCity: (String value) {
                  setState(() {
                    cityController.text=value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
