import 'package:bloc/bloc.dart';
import 'package:domain/repository/secure_storage_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'easter_egg_state.dart';

class EasterEggCubit extends Cubit<EasterEggState> {
  EasterEggCubit({
    required SharedPreferencesRepository sharedPreferencesRepository,
  })  : _sharedPreferencesRepository = sharedPreferencesRepository,
        super(EasterEggInitial());

  final SharedPreferencesRepository _sharedPreferencesRepository;

  Future<void> playEasterEgg(Duration time) async {
    if (_sharedPreferencesRepository.getIsActiveEaster()) {
      if (time.inMinutes >= 1) {
        emit(EasterEggPlay());
      } else {
        emit(EasterEggBulling());
        await Future.delayed(const Duration(seconds: 5));
        emit(EasterEggInitial());
      }
    }
  }
}
