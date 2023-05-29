part of 'projects_bloc.dart';

@immutable
abstract class ProjectsEvent {}

class ProjectsFetch extends ProjectsEvent {}

class ProjectsSelectProject extends ProjectsEvent {
  final ProjectModel? project;

  ProjectsSelectProject(this.project);
}

class ProjectsSearchProject extends ProjectsEvent {
  final String searchValue;

  ProjectsSearchProject(this.searchValue);
}
