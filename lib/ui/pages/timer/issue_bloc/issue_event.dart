part of 'issue_bloc.dart';

abstract class IssueEvent {}

class IssueAdd extends IssueEvent {
  final IssueModel issue;

  IssueAdd(this.issue);
}

class IssueFindById extends IssueEvent {
  final String issueId;

  IssueFindById(this.issueId);
}

class IssuePushTime extends IssueEvent {
  final Duration time;

  IssuePushTime(this.time);
}

class IssueClearData extends IssueEvent {}

class IssueSetActivity extends IssueEvent {
  final ValueModel activity;

  IssueSetActivity(this.activity);
}
