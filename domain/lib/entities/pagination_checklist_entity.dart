import 'package:domain/entities/checklist_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_checklist_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginationChecklistEntity {
  final List<ChecklistEntity> checklists;
  @JsonKey(name: 'total_count')
  final int totalCount;

  PaginationChecklistEntity(this.checklists, this.totalCount);

  factory PaginationChecklistEntity.fromJson(Map<String, dynamic> json) =>
      _$PaginationChecklistEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationChecklistEntityToJson(this);
}
