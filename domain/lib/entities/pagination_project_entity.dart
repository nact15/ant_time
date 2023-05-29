import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_project_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginationProjectEntity {
  final List<ProjectEntity> projects;

  PaginationProjectEntity(this.projects);

  factory PaginationProjectEntity.fromJson(Map<String, dynamic> json) => _$PaginationProjectEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationProjectEntityToJson(this);
}