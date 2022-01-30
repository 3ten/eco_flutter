import 'package:eco/models/report_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key? key, required this.item, this.onTap})
      : super(key: key);
  final ReportModel item;
  final void Function()? onTap;

  String getRating() {
    if (item.criteria == null) return "0.0";
    num ratingSum = item.criteria
            ?.fold(0, (num? sum, value) => (sum ?? 0) + (value.rating ?? 0)) ??
        0;
    return (ratingSum / (item.criteria?.length ?? 1)).toStringAsFixed(1);
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
    String rating = getRating();
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
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              "http://188.225.18.212/img/" +
                                  (item.description?.images![0] ?? ""),
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: Text(
                                item.description!.title ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Рейтинг  ' + rating),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('г. ' + (item.city ?? ""))),
                  if (item.dateStart != null)
                    Text(
                        "${item.dateStart?.year.toString()}-${item.dateStart?.month.toString().padLeft(2, '0')}-${item.dateStart?.day.toString().padLeft(2, '0')}"),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
