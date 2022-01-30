import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';


@JsonSerializable()
class Info {
  Info({this.title="", this.text="", this.icons});
  String title;
  String text;
  List<String>? icons = [];

  Map<String, dynamic> toJson() => _$InfoToJson(this);

  @override
  factory Info.fromJson(Map<String, dynamic> json) =>
      _$InfoFromJson(json);
}
