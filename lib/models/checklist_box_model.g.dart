// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_box_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChecklistBox _$ChecklistBoxFromJson(Map<String, dynamic> json) => ChecklistBox(
      label: json['label'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ChecklistBoxToJson(ChecklistBox instance) =>
    <String, dynamic>{
      'label': instance.label,
      'isSelected': instance.isSelected,
    };
