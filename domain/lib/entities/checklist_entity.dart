import 'package:json_annotation/json_annotation.dart';

part 'checklist_entity.g.dart';

@JsonSerializable()
class ChecklistEntity {
  final int id;
  @JsonKey(name: 'issue_id')
  final int issueId;
  final String subject;
  @JsonKey(name: 'is_done')
  final bool isDone;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ChecklistEntity({
    required this.id,
    required this.issueId,
    required this.subject,
    required this.isDone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistEntity.fromJson(Map<String, dynamic> json) => _$ChecklistEntityFromJson(json);

  Map<String, dynamic> toJson() => {
        "checklist": {
          "id": id,
          "issue_id": issueId,
          "is_done": isDone,
        },
      };
}
