import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  CityModel({required this.value});

  String value;

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  @override
  factory CityModel.fromJson(Map<String, dynamic> json)  =>
      _$CityModelFromJson(json);

}