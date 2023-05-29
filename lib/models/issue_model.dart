import 'package:ant_time_flutter/models/attachment_model.dart';
import 'package:ant_time_flutter/models/value_model.dart';
import 'package:domain/entities/issue_entity.dart';

class IssueModel {
  int id;
  ValueModel project;
  ValueModel tracker;
  ValueModel status;
  ValueModel priority;
  ValueModel author;
  ValueModel? assignedTo;
  String description;
  DateTime createdOn;
  DateTime updatedOn;
  String subject;
  Duration pushedTime;
  List<AttachmentModel> attachments;
  ValueModel? fixedVersion;
  String? startDate;
  String? dueDate;
  int? doneRatio;
  bool? isPrivate;
  List<ValueModel>? customFields;
  bool favorite;

  IssueModel({
    required this.id,
    required this.project,
    required this.tracker,
    required this.status,
    required this.priority,
    required this.author,
    required this.assignedTo,
    required this.subject,
    required this.attachments,
    this.pushedTime = Duration.zero,
    this.fixedVersion,
    this.description = '',
    this.startDate,
    this.dueDate,
    this.doneRatio,
    this.isPrivate,
    required this.createdOn,
    required this.updatedOn,
    this.customFields,
    this.favorite = false,
  });

  factory IssueModel.mapToModel(
    IssueEntity entity, {
    bool favorite = false,
  }) {
    return IssueModel(
      createdOn: entity.createdOn,
      updatedOn: entity.updatedOn,
      id: entity.id,
      description: entity.description ?? '',
      doneRatio: entity.doneRatio,
      dueDate: entity.dueDate,
      isPrivate: entity.isPrivate,
      startDate: entity.startDate,
      subject: entity.subject,
      attachments: entity.attachments?.map((e) => AttachmentModel.mapToModel(e)).toList() ?? [],
      tracker: ValueModel.mapToModel(entity.tracker),
      author: ValueModel.mapToModel(entity.author),
      project: ValueModel.mapToModel(entity.project),
      status: ValueModel.mapToModel(entity.status),
      customFields: entity.customFields?.map((e) => ValueModel.mapToModel(e)).toList(),
      assignedTo: entity.assignedTo != null ? ValueModel.mapToModel(entity.assignedTo!) : null,
      priority: ValueModel.mapToModel(entity.priority),
      fixedVersion: entity.fixedVersion != null
          ? ValueModel.mapToModel(
              entity.fixedVersion!,
            )
          : null,
      favorite: favorite,
    );
  }

  IssueModel copyWith({
    int? id,
    ValueModel? project,
    ValueModel? tracker,
    ValueModel? status,
    ValueModel? priority,
    ValueModel? author,
    ValueModel? assignedTo,
    String? description,
    DateTime? createdOn,
    DateTime? updatedOn,
    String? subject,
    Duration? pushedTime,
    ValueModel? fixedVersion,
    String? startDate,
    String? dueDate,
    int? doneRatio,
    bool? isPrivate,
    List<ValueModel>? customFields,
    List<AttachmentModel>? attachments,
  }) {
    return IssueModel(
      id: id ?? this.id,
      project: project ?? this.project,
      tracker: tracker ?? this.tracker,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      author: author ?? this.author,
      assignedTo: assignedTo ?? this.assignedTo,
      description: description ?? this.description,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      subject: subject ?? this.subject,
      pushedTime: pushedTime ?? this.pushedTime,
      fixedVersion: fixedVersion ?? this.fixedVersion,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      doneRatio: doneRatio ?? this.doneRatio,
      isPrivate: isPrivate ?? this.isPrivate,
      customFields: customFields ?? this.customFields,
      attachments: attachments ?? this.attachments,
    );
  }
}
