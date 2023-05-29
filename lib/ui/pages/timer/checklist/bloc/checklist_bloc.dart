import 'dart:async';
import 'dart:developer';

import 'package:ant_time_flutter/models/checklist_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data/repository/checklist_repository.dart';
import 'package:meta/meta.dart';

part 'checklist_event.dart';

part 'checklist_state.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  ChecklistBloc({
    required ChecklistRepository checklistRepository,
  })  : _checklistRepository = checklistRepository,
        super(
          ChecklistState(status: ChecklistStatus.initial),
        ) {
    on<ChecklistUpdate>(
      _onChecklistUpdate,
      transformer: concurrent(),
    );
    on<ChecklistFetch>(_onChecklistFetch);
  }

  final ChecklistRepository _checklistRepository;

  Future<FutureOr<void>> _onChecklistUpdate(ChecklistUpdate event, _) async {
    try {
      await _checklistRepository.updateChecklist(
        checklistId: event.checklist.id,
        checklist: event.checklist.toEntity(),
      );
    } catch (error) {
      log(error.toString());
    }
  }

  Future<FutureOr<void>> _onChecklistFetch(
    ChecklistFetch event,
    Emitter<ChecklistState> emit,
  ) async {
    try {
      final List<ChecklistModel> checklists = await _checklistRepository
          .getChecklist(
            issueId: event.issueId,
          )
          .then((data) => data.checklists
              .map(
                (e) => ChecklistModel.mapToModel(e),
              )
              .toList());
      emit(state.copyWith(
        status: ChecklistStatus.data,
        checklists: checklists,
      ));
    } catch (error) {
      log(error.toString());
    }
  }
}
