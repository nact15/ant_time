import 'dart:async';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/usecases/hive_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

part 'activity_event.dart';

part 'activity_state.dart';

class ActivityBloc extends BaseBloc<ActivityEvent, ActivityState> {
  ActivityBloc({
    required IssuesRepository issuesRepository,
    required HiveUseCase<ValueModel> defaultActivityUseCase,
  })  : _issuesRepository = issuesRepository,
        _defaultActivityUseCase = defaultActivityUseCase,
        super(ActivityState(status: LoadingStatus())) {
    on<ActivitySelectActivity>(_onActivitySelectActivity);
    on<ActivitySelectDefault>(_onActivitySelectDefault);
    on<ActivityClear>(_onActivityClear);
    on<ActivityFetchActivities>(_onActivityFetchActivities);
  }

  final IssuesRepository _issuesRepository;
  final HiveUseCase<ValueModel> _defaultActivityUseCase;

  Future<FutureOr<void>> _onActivitySelectDefault(
    ActivitySelectDefault event,
    Emitter<ActivityState> emit,
  ) async {
    await _defaultActivityUseCase.updateBox(event.defaultActivity);
    emit(state.copyWith(
      selectedActivity: event.defaultActivity,
      status: SelectedActivityStatus(),
    ));
  }

  FutureOr<void> _onActivityClear(
    _,
    Emitter<ActivityState> emit,
  ) {
    final ValueModel? defaultActivity = _defaultActivityUseCase.getValue();

    emit(state.copyWith(
      status: defaultActivity != null ? SelectedActivityStatus() : DataStatus(),
      selectedActivity: defaultActivity,
    ));
  }

  Future<FutureOr<void>> _onActivityFetchActivities(
    _,
    Emitter<ActivityState> emit,
  ) async {
    try {
      final List<ValueModel> activities = await _issuesRepository.getActivities().then(
            (value) => value.activities
                .map(
                  (e) => ValueModel.mapToModel(e),
                )
                .toList(),
          );

      final ValueModel? defaultActivity = _defaultActivityUseCase.getValue();

      emit(state.copyWith(
        status: defaultActivity != null ? SelectedActivityStatus() : DataStatus(),
        activities: activities,
        selectedActivity: defaultActivity,
      ));
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  FutureOr<void> _onActivitySelectActivity(
    ActivitySelectActivity event,
    Emitter<ActivityState> emit,
  ) {
    emit(state.copyWith(
      status: SelectedActivityStatus(),
      selectedActivity: event.activity,
    ));
  }
}
