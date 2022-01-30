import 'package:eco/models/report_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({Key? key, required this.item, this.onTap})
      : super(key: key);
  final ReportModel item;
  final void Function()? onTap;

  int getProgress() {
    var length = 0;
    var exist = 0;

    var jsonItem = item.toJson();

    var keys = [
      "name",
      "date_start",
      "date_end",
      "city",
      "address",
      "description",
      "criteria"
    ];

    for (var key in keys) {
      length++;

      if (key == 'criteria') {
        if (jsonItem[key]?.length > 0) exist++;
      } else if (key == 'description') {
        length++;
        if (jsonItem[key]!.images?.length > 0) exist++;
        if (jsonItem[key]?.title != null) exist++;
      } else {
        if (jsonItem[key] != null) exist++;
      }
    }

    return (exist).round();
  }

  Widget getStatus() {
    if (item.status == 'check') {
      return const Text('На проверке',
          style:
              TextStyle(color: Color(0xFF5bc0de), fontWeight: FontWeight.bold));
    }
    if (item.status == 'rejected') {
      return const Text('Отклонен',
          style:
              TextStyle(color: Color(0xFFd9534f), fontWeight: FontWeight.bold));
    }
    if (item.status == 'accepted') {
      return const Text('Принят',
          style:
              TextStyle(color: Color(0xFF5cb85c), fontWeight: FontWeight.bold));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    int progress = getProgress();
    return Card(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 17, left: 12, right: 12, bottom: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (item.description?.images != null)
                      if (item.description!.images!.isEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              'https://api.data-krat.ru/4631152378431.png',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    if (item.description?.images != null)
                      if (item.description!.images!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "http://188.225.18.212/img/" +
                                (item.description?.images![0] ?? ""),
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Expanded(
                              child: Text(
                                item.description!.title ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('г. ' + (item.city ?? "")),
                                if (item.dateStart != null)
                                  Text(
                                      "${item.dateStart?.year.toString()}-${item.dateStart?.month.toString().padLeft(2, '0')}-${item.dateStart?.day.toString().padLeft(2, '0')}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (item.status == 'draft')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Прогресс заполнения',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 15,
                      decoration: BoxDecoration(
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(4)),
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: progress == 8
                                      ? const Color(0xFF73FF71)
                                      : Colors.yellow,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          Expanded(flex: 8 - progress, child: Container())
                        ],
                      ),
                    )
                  ],
                )
              else
                getStatus()
            ],
          ),
        ),
      ),
    );
  }
}
