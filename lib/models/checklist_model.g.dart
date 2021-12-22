// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checklist _$ChecklistFromJson(Map<String, dynamic> json) => Checklist(
      title: json['title'] as String,
      boxes: (json['boxes'] as List<dynamic>)
          .map((e) => ChecklistBox.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ChecklistToJson(Checklist instance) => <String, dynamic>{
      'title': instance.title,
      'boxes': instance.boxes,
      'isSelected': instance.isSelected,
    };
