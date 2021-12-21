import 'package:eco/providers/checklist_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/checklist_collapsed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

class CheckListScreen extends StatefulWidget {
  static const route = '/checklist';

  const CheckListScreen({Key? key}) : super(key: key);

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  bool isChecklist = false;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() {
    final checklist = context.read<CheckListProvider>();
    checklist.getChecklist();
    checklist.getTitle();
  }

  @override
  Widget build(BuildContext context) {
    final checklist = context.watch<CheckListProvider>();
    final user = context.watch<UserProvider>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Чек-лист')),
        body: RefreshIndicator(
          onRefresh: () async {
            fetch();
          },
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Чек-лист мероприятия",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(checklist.title)),
              for (var i = 0; i < checklist.checklist.length; i++)
                ChecklistCollapsed(item: checklist.checklist[i], i: i),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        margin: const EdgeInsets.only(bottom: 50,top: 10),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 50,right: 20,top:10),
                      height: 1,
                      child: OutlinedButton(

                        onPressed: () {
                          context.read<CheckListProvider>().sendEmail(emailController.text);
                        },
                        child: SizedBox(
                          width: 50,
                          child: SvgPicture.asset(
                            'assets/icons/mail.svg',
                            color: const Color(0xFF7B7B7B),
                            fit:BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
