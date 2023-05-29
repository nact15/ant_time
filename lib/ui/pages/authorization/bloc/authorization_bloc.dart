import 'dart:developer';

import 'package:ant_time_flutter/di/image_header.dart';
import 'package:bloc/bloc.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/usecases/validation_usecase.dart';
import 'package:data/exceptions/exceptions.dart';
import 'package:data/repository/issues_repository.dart';
import 'package:domain/repository/secure_storage_repository.dart';
import 'package:equatable/equatable.dart';

part 'authorization_event.dart';

part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc({
    required AppLocalizations localization,
    required IssuesRepository issuesRepository,
    required SharedPreferencesRepository secureStorageRepository,
  })  : _issuesRepository = issuesRepository,
        _localization = localization,
        _sharedPreferencesRepository = secureStorageRepository,
        super(const AuthorizationState(
          status: AuthorizationStatus.initial,
        )) {
    on<AuthorizationEvent>((event, emit) async {
      final apiKey = event.apiKey.trim();
      emit(const AuthorizationState(status: AuthorizationStatus.loading));

      final error = ValidationUseCase.validate(
        validationType: ValidationType.apiKey,
        field: apiKey,
      );
      if (error != null) {
        emit(AuthorizationState(
          status: AuthorizationStatus.validationError,
          errorTitle: _localization.login,
        ));
      } else {
        try {
          await _sharedPreferencesRepository.saveApiToken(token: apiKey);
          await _issuesRepository.getIssues(limit: 5, offset: 1);

          ImageHeaders.headers = {AppConst.tokenHeader: apiKey};

          emit(const AuthorizationState(status: AuthorizationStatus.success));
        } on Unauthorized {
          await _sharedPreferencesRepository.deleteApiToken();
          emit(AuthorizationState(
            status: AuthorizationStatus.error,
            errorTitle: _localization.errorForbidden,
          ));
        } on NoInternetConnection {
          await _sharedPreferencesRepository.deleteApiToken();
          emit(AuthorizationState(
            status: AuthorizationStatus.error,
            errorTitle: _localization.errorNoInternetConnection,
          ));
        } catch (e) {
          log(e.toString());
          await _sharedPreferencesRepository.deleteApiToken();
          emit(AuthorizationState(
            status: AuthorizationStatus.error,
            errorTitle: _localization.errorSomethingWentWrong,
          ));
        }
      }
    });
  }

  final AppLocalizations _localization;
  final IssuesRepository _issuesRepository;
  final SharedPreferencesRepository _sharedPreferencesRepository;
}
