part of 'issues_bloc.dart';

class IssuesState extends BaseState {
  final List<IssueModel> issues;
  final int page;
  final String? errorTitle;
  final int? projectId;
  final int endPage;
  final String? searchSubject;
  final TypeIssues typeIssues;

  bool get lastPage => page >= endPage && page != 0;

  IssuesState({
    required BaseStatus status,
    this.issues = const [],
    this.errorTitle,
    this.page = 0,
    this.projectId,
    this.endPage = 0,
    this.searchSubject,
    this.typeIssues = TypeIssues.all,
  }) : super(status: status);

  @override
  IssuesState copyWith({
    BaseStatus? status,
    List<IssueModel>? issues,
    int? page,
    String? errorTitle,
    int? projectId,
    int? endPage,
    String? searchSubject,
    bool clearSearch = false,
    TypeIssues? typeIssues,
  }) {
    return IssuesState(
      status: status ?? this.status,
      page: page ?? this.page,
      errorTitle: errorTitle ?? this.errorTitle,
      issues: issues ?? this.issues,
      projectId: (projectId?.isNegative ?? false) ? null : (projectId ?? this.projectId),
      endPage: endPage ?? this.endPage,
      searchSubject: clearSearch ? null : (searchSubject ?? this.searchSubject),
      typeIssues: typeIssues ?? this.typeIssues,
    );
  }
}

class EmptyStatus extends BaseStatus {}
