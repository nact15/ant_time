import 'package:ant_time_flutter/models/base_model.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  int id;
  String name;
  String description;

  ProjectModel({
    required this.id,
    required this.name,
    this.description = '',
  });

  factory ProjectModel.mapToModel(ProjectEntity entity) {
    return ProjectModel(
      id: entity.id,
      name: entity.name,
      description: entity.description ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, description];
}
