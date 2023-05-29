part of 'projects_bloc.dart';

class ProjectsState extends BaseState {
  final List<ProjectModel> projects;
  final List<ProjectModel>? searchingProjects;
  final ProjectModel? selectedProject;

  ProjectsState({
    required BaseStatus status,
    this.projects = const [],
    this.searchingProjects,
    this.selectedProject,
  }) : super(status: status);

  @override
  ProjectsState copyWith({
    BaseStatus? status,
    List<ProjectModel>? projects,
    List<ProjectModel>? searchingProjects,
    ProjectModel? selectedProject,
  }) {
    return ProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      selectedProject: selectedProject,
      searchingProjects: searchingProjects,
    );
  }
}
