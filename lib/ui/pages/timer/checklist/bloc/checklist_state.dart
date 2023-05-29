part of 'checklist_bloc.dart';

enum ChecklistStatus { data, error, initial }

class ChecklistState {
  final ChecklistStatus status;
  final List<ChecklistModel> checklists;

  ChecklistState({
    required this.status,
    this.checklists = const [],
  });

  ChecklistState copyWith({
    ChecklistStatus? status,
    List<ChecklistModel>? checklists,
  }) {
    return ChecklistState(
      status: status ?? this.status,
      checklists: checklists ?? this.checklists,
    );
  }
}
