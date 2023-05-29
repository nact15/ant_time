part of 'activity_bloc.dart';

abstract class ActivityEvent {}

class ActivityFetchActivities extends ActivityEvent {}

class ActivitySelectActivity extends ActivityEvent {
  final ValueModel activity;

  ActivitySelectActivity(this.activity);
}

class ActivityClear extends ActivityEvent {}

class ActivitySelectDefault extends ActivityEvent {
  final ValueModel defaultActivity;

  ActivitySelectDefault(this.defaultActivity);
}
