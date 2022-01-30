import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  User({this.id,  this.email,  this.name, this.city});

  String? id;
  String? email;
  String? busyness;
  String? name;
  String? city;
  String? password;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  factory User.fromJson(Map<String, dynamic> json)  =>
      _$UserFromJson(json);
}
