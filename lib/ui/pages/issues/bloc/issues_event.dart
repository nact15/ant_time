part of 'issues_bloc.dart';

abstract class IssuesEvent extends Equatable {}

class IssuesFindById extends IssuesEvent {
  final int issueId;

  IssuesFindById(this.issueId);

  @override
  List<Object?> get props => [issueId];
}

class IssuesChangeFavorite extends IssuesEvent {
  final IssueModel issue;

  IssuesChangeFavorite(this.issue);

  @override
  List<Object?> get props => [issue];
}

class IssuesAddHistory extends IssuesEvent {
  final IssueModel? issue;

  IssuesAddHistory(this.issue);

  @override
  List<Object?> get props => [issue];
}

class IssuesFetch extends IssuesEvent {
  final int? page;
  final int? projectId;
  final String? searchSubject;
  final bool clearSearch;
  final TypeIssues? typeIssues;

  IssuesFetch({
    this.page,
    this.projectId,
    this.searchSubject,
    this.typeIssues,
    required this.clearSearch,
  });

  @override
  List<Object?> get props => [page, projectId, searchSubject, clearSearch];
}

enum TypeIssues { all, favorites, history }
