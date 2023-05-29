import 'dart:async';

import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/usecases/hive_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:domain/domain.dart';
import 'package:domain/repository/secure_storage_repository.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required SharedPreferencesRepository secureStorageRepository,
    required FavoritesRepository favoritesRepository,
    required HiveUseCase<ValueModel> defaultActivityUseCase,
  })  : _sharedPreferencesRepository = secureStorageRepository,
        _defaultActivityUseCase = defaultActivityUseCase,
        _favoritesRepository = favoritesRepository,
        super(SettingsState(status: SettingsStatus.initial)) {
    on<SettingsLogout>(_onSettingsLogout);

    on<SettingsGetProperties>(_onSettingsGetProperties);

    on<SettingsChangeEasterEgg>(
      _onSettingsChangeEasterEgg,
      transformer: restartable(),
    );

    on<SettingsChangeThemeMode>(
      _onSettingsChangeThemeMode,
      transformer: restartable(),
    );
  }

  final SharedPreferencesRepository _sharedPreferencesRepository;
  final FavoritesRepository _favoritesRepository;
  final HiveUseCase<ValueModel> _defaultActivityUseCase;

  Future<FutureOr<void>> _onSettingsChangeEasterEgg(
    SettingsChangeEasterEgg event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isActiveEaster: event.isActive));
    await _sharedPreferencesRepository.setIsActiveEaster(event.isActive);
  }

  FutureOr<void> _onSettingsGetProperties(
    _,
    Emitter<SettingsState> emit,
  ) {
    final bool isActiveEaster = _sharedPreferencesRepository.getIsActiveEaster();
    final bool isDark = _sharedPreferencesRepository.getIsDark();
    emit(state.copyWith(
      isActiveEaster: isActiveEaster,
      isDarkTheme: isDark,
    ));
  }

  Future<FutureOr<void>> _onSettingsLogout(
    _,
    Emitter<SettingsState> emit,
  ) async {
    await _sharedPreferencesRepository.deleteApiToken();
    await _defaultActivityUseCase.clearBox();
    await _favoritesRepository.clearData();
    emit(state.copyWith(status: SettingsStatus.logout));
  }

  Future<FutureOr<void>> _onSettingsChangeThemeMode(
    SettingsChangeThemeMode event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      isDarkTheme: event.isDark,
      status: SettingsStatus.switchTheme,
    ));
    await _sharedPreferencesRepository.setIsDark(event.isDark);
  }
}
