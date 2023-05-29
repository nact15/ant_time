import 'dart:async';
import 'dart:developer';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/models/issue_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data/data.dart';
import 'package:data/exceptions/exceptions.dart';
import 'package:domain/repository/favorites_reposirory.dart';
import 'package:equatable/equatable.dart';

import '../../../../usecases/favorite_usecase.dart';
import '../../timer/issue_bloc/issue_bloc.dart';

part 'issues_event.dart';

part 'issues_state.dart';

class IssuesBloc extends BaseBloc<IssuesEvent, IssuesState> {
  IssuesBloc({
    required IssuesRepository issuesRepository,
    required FavoritesRepository favoritesRepository,
    required FavoriteUseCase favoriteUseCase,
  })  : _issuesRepository = issuesRepository,
        _favoritesRepository = favoritesRepository,
        super(IssuesState(status: InitialStatus())) {
    on<IssuesFetch>(
      _onIssuesFetch,
      transformer: restartable(),
    );

    on<IssuesChangeFavorite>(_onIssuesChangeFavorite);

    on<IssuesAddHistory>(_onIssuesAddHistory);
  }

  final IssuesRepository _issuesRepository;
  final FavoritesRepository _favoritesRepository;

  Future<void> _onIssuesFetch(IssuesFetch event, Emitter<IssuesState> emit) async {
    try {
      if (state.typeIssues == event.typeIssues) return;
      emit(state.copyWith(typeIssues: event.typeIssues));

      final page = event.page ?? state.page;
      final endPage = (event.projectId != null || event.searchSubject != null || event.typeIssues != null)
          ? 0
          : state.endPage;
      if (page > endPage) return;

      String? searchSubject;
      if (event.searchSubject?.isNotEmpty ?? false) {
        searchSubject = '~${event.searchSubject}';
      }

      emit(state.copyWith(
        status: page == 0 ? InitialStatus() : LoadingStatus(),
        page: page + 1,
        issues: page == 0 ? [] : state.issues,
        projectId: event.projectId ?? state.projectId,
        searchSubject: searchSubject,
        clearSearch: event.clearSearch || (event.searchSubject?.isEmpty ?? false),
      ));

      String? searchIds;
      switch (event.typeIssues ?? state.typeIssues) {
        case TypeIssues.all:
          break;
        case TypeIssues.favorites:
          searchIds = _favoritesRepository.getFavoriteTasks().join(',');
          if (searchIds.isEmpty) {
            emit(state.copyWith(status: EmptyStatus()));

            return;
          }
          break;
        case TypeIssues.history:
          searchIds = _favoritesRepository.getHistoryTasks().reversed.join(',');
          if (searchIds.isEmpty) {
            emit(state.copyWith(status: EmptyStatus()));

            return;
          }
          break;
      }

      final data = await _issuesRepository.getIssues(
        offset: (state.page - 1) * AppConst.defaultIssuesLimit,
        limit: AppConst.defaultIssuesLimit,
        projectId: state.projectId,
        searchSubject: state.searchSubject,
        ids: searchIds,
      );

      final favoritesTasks = _favoritesRepository.getFavoriteTasks();
      final List<IssueModel> issues = data.issues
          .map(
            (e) => IssueModel.mapToModel(
              e,
              favorite: favoritesTasks.contains(e.id.toString()),
            ),
          )
          .toList();

      final totalPages = (data.totalCount / data.limit).ceil();
      if (totalPages == 0 || issues.isEmpty) {
        emit(state.copyWith(status: EmptyStatus()));
      } else {
        emit(state.copyWith(
          status: DataStatus(),
          issues: [...state.issues, ...issues],
          endPage: totalPages,
        ));
      }
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  FutureOr<void> _onIssuesChangeFavorite(
    IssuesChangeFavorite event,
    Emitter<IssuesState> emit,
  ) async {
    if (event.issue.favorite) {
      await _favoritesRepository.removeFavoriteTask(taskId: event.issue.id.toString());
    } else {
      await _favoritesRepository.saveFavoriteTask(taskId: event.issue.id.toString());
    }
    event.issue.favorite = !event.issue.favorite;
    emit(state.copyWith(status: state.status));
  }

  FutureOr<void> _onIssuesAddHistory(IssuesAddHistory event, _) async {
    if (event.issue != null) {
      await _favoritesRepository.saveHistoryTask(taskId: event.issue!.id.toString());
    }
  }
}
