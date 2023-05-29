part of 'issue_bloc.dart';

class IssueState extends BaseState {
  final IssueModel? issue;

  const IssueState({
    required BaseStatus status,
    this.issue,
  }) : super(status: status);

  @override
  IssueState copyWith({
    BaseStatus? status,
    IssueModel? issue,
  }) {
    return IssueState(
      status: status ?? this.status,
      issue: issue ?? this.issue,
    );
  }
}

extension SnowNotificationStatusExtension on BaseStatus {
  bool get isShowNotification => this is SnowNotificationStatus;
}

class SnowNotificationStatus extends BaseStatus {
  final String message;

  SnowNotificationStatus(this.message);
}
