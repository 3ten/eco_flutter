import 'package:eco/providers/user_provider.dart';
import 'package:eco/screens/auth/register.dart';
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
  TextEditingController dealController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late UserProvider setting;

  @override
  void initState() {
    context.read<UserProvider>().getProfile();
    setting = context.read<UserProvider>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    dealController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    if (emailController.text != userProvider.user?.email) {
      emailController.text = userProvider.user?.email ?? "";
    }
    if (nameController.text != userProvider.user?.name) {
      nameController.text = userProvider.user?.name ?? "";
    }
    if (dealController.text != userProvider.user?.busyness) {
      dealController.text = userProvider.user?.busyness ?? "";
    }
    if (cityController.text != userProvider.user?.city) {
      cityController.text = userProvider.user?.city ?? "";
    }

    FocusScopeNode currentFocus = FocusScope.of(context);
    String city = '';
    // final user = context.watch<UserProvider>();
    return Listener(
      onPointerDown: (_) {
        print(currentFocus.focusedChild);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: !userProvider.isAuth
          ? const RegisterScreen()
          : Scaffold(
              appBar: AppBar(title: const Text('Настройки')),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextInput(
                      label: 'Email',
                      controller: emailController,
                      onChanged: (value) {
                        setting.setUser(email: value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInput(
                      label: 'ФИО',
                      controller: nameController,
                      onChanged: (value) {
                        setting.setUser(name: value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInput(
                      label: 'Вид деятельности',
                      onChanged: (value) {
                        setting.setUser(busyness: value);
                      },
                      controller: dealController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CityPicker(
                      controller: cityController,
                      setCity: (String value) {
                        setState(() {
                          cityController.text = value;
                          setting.setUser(city: value);
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Сохранить')),
                    ElevatedButton(
                        onPressed: () {
                          userProvider.logout();
                        },
                        child: const Text('Выйти'))
                  ],
                ),
              ),
            ),
    );
  }
}
