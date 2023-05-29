class TimeEntryEntity {
  final int issueId;
  final double hours;
  final int activityId;

  TimeEntryEntity({
    required this.issueId,
    required this.hours,
    required this.activityId,
  });

  Map<String, dynamic> toJson() {
    return {
      'time_entry': {
        'issue_id': issueId,
        'hours': hours,
        'activity_id': activityId,
      },
    };
  }
}
