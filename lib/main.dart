import 'package:eco/providers/checklist_provider.dart';
import 'package:eco/providers/navigation_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CheckListProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
          );
        }
      ),
    );
  }
}

