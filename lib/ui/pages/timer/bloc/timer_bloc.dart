import 'dart:async';

import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({
    required IssueBloc issueBloc,
  })  : _issueBloc = issueBloc,
        super(TimerState(
          duration: const Duration(seconds: 0),
          status: TimerStatus.initial,
        )) {
    on<TimerStart>((event, emit) {
      emit(state.copyWith(status: TimerStatus.running));
      _tickerSubscription = tick().listen((tick) {
        add(TimerTicked(tick));
        if (tick.inMinutes > 1 && tick.inSeconds % AppConst.pushInterval == 0) {
          _issueBloc.add(IssuePushTime(tick));
        }
      });
    });
    on<TimerTicked>((event, emit) {
      emit(state.copyWith(duration: event.duration));
    });
    on<TimerRestart>((event, emit) {
      _currentTime = 0;
      emit(state.copyWith(duration: Duration.zero));
    });
    on<TimerPause>((event, emit) {
      _tickerSubscription?.pause();
      emit(state.copyWith(status: TimerStatus.paused));
    });
  }

  final IssueBloc _issueBloc;

  int _currentTime = 0;

  StreamSubscription<Duration>? _tickerSubscription;

  Stream<Duration> tick() {
    return Stream<Duration>.periodic(
      const Duration(seconds: 1),
      (_) => Duration(seconds: _currentTime++),
    );
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();

    return super.close();
  }
}
