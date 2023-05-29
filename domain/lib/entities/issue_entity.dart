import 'package:domain/entities/attachment_entity.dart';
import 'package:domain/entities/value_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class IssueEntity {
  final int id;
  final ValueEntity project;
  final ValueEntity tracker;
  final ValueEntity status;
  final ValueEntity priority;
  final ValueEntity author;
  @JsonKey(name: 'assigned_to')
  final ValueEntity? assignedTo;
  @JsonKey(name: 'fixed_version')
  final ValueEntity? fixedVersion;
  final String subject;
  final String? description;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'dueDate')
  final String? dueDate;
  @JsonKey(name: 'done_ratio')
  final int? doneRatio;
  @JsonKey(name: 'is_private')
  final bool? isPrivate;
  @JsonKey(name: 'created_on')
  final DateTime createdOn;
  @JsonKey(name: 'updated_on')
  final DateTime updatedOn;
  final List<AttachmentEntity>? attachments;
  @JsonKey(name: 'custom_fields')
  final List<ValueEntity>? customFields;

  IssueEntity(
    this.id,
    this.project,
    this.tracker,
    this.status,
    this.priority,
    this.author,
    this.assignedTo,
    this.fixedVersion,
    this.subject,
    this.description,
    this.startDate,
    this.dueDate,
    this.doneRatio,
    this.isPrivate,
    this.createdOn,
    this.updatedOn,
    this.customFields,
    this.attachments,
  );

  factory IssueEntity.fromJson(Map<String, dynamic> json) => _$IssueEntityFromJson(json);

  Map<String, dynamic> toJson() => _$IssueEntityToJson(this);
}

IssueEntity deserializeIssueEntity(Map<String, dynamic> json) {
  return IssueEntity.fromJson(json['issue']);
}

List<IssueEntity> deserializeIssueEntityList(List<Map<String, dynamic>> json) =>
    json.map((e) => IssueEntity.fromJson(e)).toList();

Map<String, dynamic> serializeIssueEntity(IssueEntity object) => object.toJson();

List<Map<String, dynamic>> serializeIssueEntityList(List<IssueEntity> objects) =>
    objects.map((e) => e.toJson()).toList();
