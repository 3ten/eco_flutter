import 'package:json_annotation/json_annotation.dart';

part 'checklist_model.g.dart';



@JsonSerializable()
class Checklist {
  Checklist(
      {required this.title, required this.boxes, this.isSelected = false});

  String title;
  List<ChecklistBox> boxes;
  bool isSelected;

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);


  factory Checklist.fromJson(Map<String, dynamic> obj) {
    var _boxes = [];
    print(obj['boxes'].runtimeType);
    for (var item in obj['boxes']) {
      _boxes.add(ChecklistBox.fromJson(item));
    }
    return Checklist(
        title: (obj['title']).toString(),
        boxes: _boxes,
        isSelected:obj['isSelected']??false,
    );
  }
}
