import 'package:json_annotation/json_annotation.dart';

part 'criteria.g.dart';


@JsonSerializable()
class Criteria {
  Criteria({this.name, this.images,this.rating});
  String? name;

  List<String>? images;
  num? rating;

  Map<String, dynamic> toJson() => _$CriteriaToJson(this);

  @override
  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);
}
