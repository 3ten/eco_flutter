import 'package:json_annotation/json_annotation.dart';

part 'checklist_box_model.g.dart';

@JsonSerializable()
class ChecklistBox {
  ChecklistBox({required this.label, this.isSelected = false});

  String label;
  bool isSelected;

  factory ChecklistBox.fromJson(Map<String, dynamic> json) =>
      _$ChecklistBoxFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistBoxToJson(this);
}
