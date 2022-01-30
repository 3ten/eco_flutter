import 'package:json_annotation/json_annotation.dart';
import 'description.dart';
import 'criteria.dart';

part 'report_model.g.dart';


@JsonSerializable()
class ReportModel {
  ReportModel({this.id,this.name,this.dateStart,this.dateEnd,this.status ="draft",this.city,this.address,this.description,this.criteria});
  @JsonKey(name: '_id',fromJson: null, includeIfNull: false)
  String? id;
  @JsonKey(includeIfNull: false)
  String? name;

  @JsonKey(name: 'date_start',includeIfNull: false)
  DateTime? dateStart;

  @JsonKey(name: 'date_end',includeIfNull: false)
  DateTime? dateEnd;
  @JsonKey(includeIfNull: false)
  String? city;
  @JsonKey(includeIfNull: false)
  String? address;
  @JsonKey(includeIfNull: false)
  Description? description;
  @JsonKey(includeIfNull: false)
  String? status ;
  @JsonKey(includeIfNull: false)
  List<Criteria>? criteria;
  @JsonKey(includeIfNull: false)
  String? rating ;



  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  @override
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}
