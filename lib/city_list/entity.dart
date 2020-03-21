
import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class ProvinceEntity {
  String name;
  String code;
  List<CityEntity> city;

  ProvinceEntity(this.name, this.code, this.city);

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) => _$ProvinceEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceEntityToJson(this);
}

@JsonSerializable()
class CityEntity {
  String name;
  String code;
  List<AreaEntity> area;

  CityEntity(this.name, this.code, this.area);

  factory CityEntity.fromJson(Map<String, dynamic> json) => _$CityEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CityEntityToJson(this);

}

@JsonSerializable()
class AreaEntity {
  String name;
  String code;

  AreaEntity(this.name, this.code);

  factory AreaEntity.fromJson(Map<String, dynamic> json) => _$AreaEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AreaEntityToJson(this);

}