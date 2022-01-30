import 'package:eco/providers/info_provider.dart';
import 'package:eco/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatefulWidget {
  static const route = '/info';

  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() {
    var info = context.read<InfoProvider>();
    info.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    final infoProvider = context.watch<InfoProvider>();
    final info = infoProvider.info;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инфо'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getInfo();
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              info.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(info.text),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: info.icons?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  // return Container();
                  return Container(margin: EdgeInsets.only(right: 10),child: Image.network(info.icons![index]));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
