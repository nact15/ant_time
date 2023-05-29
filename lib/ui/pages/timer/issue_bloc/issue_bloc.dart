import 'dart:async';
import 'dart:developer';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/models/issue_model.dart';
import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/usecases/hive_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data/data.dart';
import 'package:data/exceptions/exceptions.dart';
import 'package:domain/domain.dart';

part 'issue_event.dart';

part 'issue_state.dart';

class IssueBloc extends BaseBloc<IssueEvent, IssueState> {
  IssueBloc({
    required IssuesRepository issuesRepository,
    required AppLocalizations localization,
    required HiveUseCase<ValueModel> defaultActivityUseCase,
  })  : _issuesRepository = issuesRepository,
        _localization = localization,
        _defaultActivityUseCase = defaultActivityUseCase,
        super(IssueState(status: DataStatus())) {
    on<IssueAdd>(_onIssueAdd);
    on<IssueFindById>(_onIssueFindById);
    on<IssuePushTime>(
      _onIssuePushTime,
      transformer: sequential(),
    );
    on<IssueSetActivity>((event, emit) {
      _issue.pushedTime = Duration.zero;
      _selectedActivity = event.activity;
    });
    on<IssueClearData>(
      (event, emit) {
        _selectedActivity = null;

        emit(IssueState(status: InitialStatus()));
      },
      transformer: sequential(),
    );
  }

  final IssuesRepository _issuesRepository;
  final AppLocalizations _localization;
  final HiveUseCase<ValueModel> _defaultActivityUseCase;
  late IssueModel _issue;
  ValueModel? _selectedActivity;

  FutureOr<void> _onIssueAdd(IssueAdd event, Emitter<IssueState> emit) {
    _issue = event.issue..pushedTime = Duration.zero;
    final ValueModel? defaultActivity = _defaultActivityUseCase.getValue();
    _selectedActivity = defaultActivity;
    emit(IssueState(
      status: DataStatus(),
      issue: _issue,
    ));
  }

  Future<void> _onIssueFindById(
    IssueFindById event,
    Emitter<IssueState> emit,
  ) async {
    try {
      emit(state.copyWith(status: LoadingStatus()));
      final int issueId = int.parse(event.issueId);
      _issue = await _issuesRepository
          .getIssueById(
            issueId: issueId,
          )
          .then(
            (data) => IssueModel.mapToModel(data),
          )
        ..pushedTime = Duration.zero;

      final ValueModel? defaultActivity = _defaultActivityUseCase.getValue();
      _selectedActivity = defaultActivity;

      emit(IssueState(
        status: DataStatus(),
        issue: _issue,
      ));
    } on NotFound {
      emit(state.copyWith(
        status: ErrorStatus(ErrorType.issueNotFound),
      ));
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  Future<FutureOr<void>> _onIssuePushTime(
    IssuePushTime event,
    Emitter<IssueState> emit,
  ) async {
    if (_selectedActivity != null) {
      final Duration unPushedTime = event.time.subtractDuration(_issue.pushedTime);
      if (unPushedTime.inMinutes >= 1) {
        try {
          final double hours = unPushedTime.inMinutes / 60;
          final TimeEntryEntity timeEntry = TimeEntryEntity(
            issueId: _issue.id,
            hours: hours,
            activityId: _selectedActivity!.id,
          );
          await _issuesRepository.pushTime(timeEntry);
          _issue.pushedTime = _issue.pushedTime.addDuration(unPushedTime);
          emit(state.copyWith(
            status: SnowNotificationStatus('${_localization.youPushedTime}: '
                '${unPushedTime.formatDurationWithoutSeconds}'),
          ));
        } catch (error, stackTrace) {
          handleError(error, stackTrace, emit);
        }
      }
    }
  }
}
