import 'package:json_annotation/json_annotation.dart';

part 'value_entity.g.dart';

@JsonSerializable()
class ValueEntity {
  final int id;
  final String name;
  final String? value;

  ValueEntity(this.id, this.name, this.value);

  factory ValueEntity.fromJson(Map<String, dynamic> json) => _$ValueEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ValueEntityToJson(this);
}
