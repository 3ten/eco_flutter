// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String?,
    )
      ..busyness = json['busyness'] as String?
      ..password = json['password'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'busyness': instance.busyness,
      'name': instance.name,
      'city': instance.city,
      'password': instance.password,
    };
