import 'package:domain/domain.dart';

class ChecklistModel {
  int id;
  int issueId;
  String subject;
  bool isDone;
  DateTime createdAt;
  DateTime updatedAt;

  ChecklistModel({
    required this.id,
    required this.issueId,
    required this.subject,
    required this.isDone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistModel.mapToModel(ChecklistEntity entity) {
    return ChecklistModel(
      id: entity.id,
      updatedAt: entity.updatedAt,
      subject: entity.subject,
      createdAt: entity.createdAt,
      issueId: entity.issueId,
      isDone: entity.isDone,
    );
  }

  ChecklistEntity toEntity() {
    return ChecklistEntity(
      issueId: issueId,
      id: id,
      isDone: isDone,
      subject: subject,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}
