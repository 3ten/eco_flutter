// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Criteria _$CriteriaFromJson(Map<String, dynamic> json) => Criteria(
      name: json['name'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: json['rating'] as num?,
    );

Map<String, dynamic> _$CriteriaToJson(Criteria instance) => <String, dynamic>{
      'name': instance.name,
      'images': instance.images,
      'rating': instance.rating,
    };
