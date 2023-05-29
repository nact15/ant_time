part of 'timer_bloc.dart';

enum TimerStatus { initial, running, paused }

extension TimerStatusExtension on TimerStatus {
  bool get isRunning => this == TimerStatus.running;

  bool get isPaused => this == TimerStatus.paused;
}

class TimerState extends Equatable {
  final TimerStatus status;
  final Duration duration;

  TimerState({
    required this.status,
    required this.duration,
  });

  TimerState copyWith({
    TimerStatus? status,
    Duration? duration,
  }) {
    return TimerState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [status, duration];
}
