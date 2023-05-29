part of 'activity_bloc.dart';

class ActivityState extends BaseState {
  final List<ValueModel> activities;
  final ValueModel? selectedActivity;

  ActivityState({
    required BaseStatus status,
    this.activities = const [],
    this.selectedActivity,
  }) : super(status: status);

  @override
  ActivityState copyWith({
    BaseStatus? status,
    List<ValueModel>? activities,
    ValueModel? selectedActivity,
  }) {
    return ActivityState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
      selectedActivity: selectedActivity,
    );
  }
}

class SelectedActivityStatus extends BaseStatus {}

extension SelectedActivityStatusExtension on BaseStatus {
  bool get notSelected => this is! SelectedActivityStatus;
}