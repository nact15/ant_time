import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_entity.g.dart';

@JsonSerializable()
class ProjectEntity extends BaseEntity {
  final int id;
  final String name;
  final String? identifier;
  final String? description;
  final int status;

  ProjectEntity(
    this.id,
    this.name,
    this.identifier,
    this.description,
    this.status,
  );

  factory ProjectEntity.fromJson(Map<String, dynamic> json) => _$ProjectEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectEntityToJson(this);
}
