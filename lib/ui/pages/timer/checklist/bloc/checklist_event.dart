part of 'checklist_bloc.dart';

@immutable
abstract class ChecklistEvent {}

class ChecklistFetch extends ChecklistEvent {
  final int issueId;

  ChecklistFetch(this.issueId);
}

class ChecklistUpdate extends ChecklistEvent {
  final ChecklistModel checklist;

  ChecklistUpdate(this.checklist);
}
