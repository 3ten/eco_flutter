import 'package:json_annotation/json_annotation.dart';

import 'checklist_box_model.dart';

part 'checklist_model.g.dart';



@JsonSerializable()
class Checklist {
  Checklist(
      {required this.title, required this.boxes, this.isSelected = false});

  String title;
  List<ChecklistBox> boxes;
  bool isSelected;

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);

  @override
  factory Checklist.fromJson(Map<String, dynamic> json)  =>
      _$ChecklistFromJson(json);
}
