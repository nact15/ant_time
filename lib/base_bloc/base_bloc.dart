import 'dart:developer';

import 'package:ant_time_flutter/resources/app_enums.dart';
import 'package:data/exceptions/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S> implements ErrorHandler<S> {
  BaseBloc(S initialState) : super(initialState);

  @override
  void handleError(
    Object error,
    StackTrace stackTrace,
    Emitter<BaseState> emit,
  ) {
    log(error.toString());
    log(stackTrace.toString());

    if (error is NoInternetConnection) {
      emit(state.copyWith(status: ErrorStatus(ErrorType.noInternetConnection)));
    } else if (error is Unauthorized) {
      emit(state.copyWith(status: ErrorStatus(ErrorType.unauthorized)));
    } else {
      emit(state.copyWith(status: ErrorStatus(ErrorType.unknown)));
    }
  }
}

abstract class ErrorHandler<S extends BaseState> {
  void handleError(Object error, StackTrace stackTrace, Emitter<S> emit);
}

abstract class BaseStatus {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BaseStatus && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

}

class ErrorStatus extends BaseStatus {
  final ErrorType errorType;

  ErrorStatus(this.errorType);
}

class InitialStatus extends BaseStatus {}

class LoadingStatus extends BaseStatus {}

class DataStatus extends BaseStatus {}

extension BaseStatusExtension on BaseStatus {
  bool get isData => this is DataStatus;

  bool get isLoading => this is LoadingStatus;

  bool get isInitial => this is InitialStatus;

  bool get isError => this is ErrorStatus;
}

abstract class StateCopyWith {
  BaseState copyWith({required BaseStatus status});
}

abstract class BaseState implements StateCopyWith {
  final BaseStatus status;

  const BaseState({required this.status});
}
