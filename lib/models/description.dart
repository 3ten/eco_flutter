import 'package:json_annotation/json_annotation.dart';

part 'description.g.dart';


@JsonSerializable()
class Description {
  Description({this.title, this.images});

  String? title;
  List<String>? images;

  Map<String, dynamic> toJson() => _$DescriptionToJson(this);

  @override
  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);
}

