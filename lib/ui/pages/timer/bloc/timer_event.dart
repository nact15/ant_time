part of 'timer_bloc.dart';

abstract class TimerEvent {}

class TimerStart extends TimerEvent {}

class TimerPause extends TimerEvent {}

class TimerFinish extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final Duration duration;

  TimerTicked(this.duration);
}

class TimerRestart extends TimerEvent {}
