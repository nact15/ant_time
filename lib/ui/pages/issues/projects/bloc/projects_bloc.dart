import 'dart:async';
import 'dart:developer';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/models/project_model.dart';
import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/resources/app_enums.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'projects_event.dart';

part 'projects_state.dart';

class ProjectsBloc extends BaseBloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc({
    required ProjectsRepository projectsRepository,
  })  : _projectsRepository = projectsRepository,
        super(ProjectsState(status: LoadingStatus())) {
    on<ProjectsFetch>(_onByProjectsFetch);

    on<ProjectsSelectProject>(_onProjectSelectProject);

    on<ProjectsSearchProject>(
      _onProjectsSearchProject,
      transformer: restartable(),
    );
  }

  final ProjectsRepository _projectsRepository;

  Future<void> _onByProjectsFetch(
    _,
    Emitter<ProjectsState> emit,
  ) async {
    try {
      emit((state.copyWith(
        status: LoadingStatus(),
        selectedProject: state.selectedProject,
      )));
      List<ProjectModel> projects = await _projectsRepository.getProjects().then(
            (data) => data.projects
                .map(
                  (e) => ProjectModel.mapToModel(e),
                )
                .toList(),
          );

      emit(state.copyWith(
        status: DataStatus(),
        projects: projects,
        selectedProject: state.selectedProject,
      ));
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  FutureOr<void> _onProjectSelectProject(
    ProjectsSelectProject event,
    Emitter<ProjectsState> emit,
  ) {
    emit(
      state.copyWith(
        selectedProject: event.project,
      ),
    );
  }

  FutureOr<void> _onProjectsSearchProject(
    ProjectsSearchProject event,
    Emitter<ProjectsState> emit,
  ) {
    List<ProjectModel>? searchingProjects;
    if (event.searchValue.trim().isNotEmpty) {
      searchingProjects = state.projects
          .where((project) => project.name.toLowerCase().contains(
                event.searchValue.trim().toLowerCase(),
              ))
          .toList();
    }

    emit(state.copyWith(searchingProjects: searchingProjects));
  }
}
