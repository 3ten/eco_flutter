// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModel _$SuperModelFromJson(Map<String, dynamic> json) => SuperModel(
      checklist: (json['checklist'] as List<dynamic>?)
          ?.map((e) => Checklist.fromJson(e as Map<String, dynamic>))
          .toList(),
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => CityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reports: (json['reports'] as List<dynamic>?)
          ?.map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelToJson(SuperModel instance) =>
    <String, dynamic>{
      'checklist': instance.checklist,
      'cities': instance.cities,
      'reports': instance.reports,
    };
