// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      dateStart: json['date_start'] == null
          ? null
          : DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] == null
          ? null
          : DateTime.parse(json['date_end'] as String),
      status: json['status'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      description: json['description'] == null
          ? null
          : Description.fromJson(json['description'] as Map<String, dynamic>),
      criteria: (json['criteria'] as List<dynamic>?)
          ?.map((e) => Criteria.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('date_start', instance.dateStart?.toIso8601String());
  writeNotNull('date_end', instance.dateEnd?.toIso8601String());
  writeNotNull('city', instance.city);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  writeNotNull('status', instance.status);
  writeNotNull('criteria', instance.criteria);
  return val;
}
