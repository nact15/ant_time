import 'package:domain/entities/value_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activities_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivitiesEntity {
  @JsonKey(name: 'time_entry_activities')
  final List<ValueEntity> activities;

  ActivitiesEntity(this.activities);

  factory ActivitiesEntity.fromJson(Map<String, dynamic> json) => _$ActivitiesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitiesEntityToJson(this);
}

ActivitiesEntity deserializeActivitiesEntity(Map<String, dynamic> json) {
  return ActivitiesEntity.fromJson(json);
}
