import 'package:eco/models/checklist_model.dart';
import 'package:eco/models/city_model.dart';
import 'package:eco/models/report_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'super_model.g.dart';

@JsonSerializable()
class SuperModel{
  List<Checklist>? checklist;
  List<CityModel>? cities;
  List<ReportModel>? reports;
  SuperModel({ this.checklist,this.cities,this.reports });

  factory SuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);

}