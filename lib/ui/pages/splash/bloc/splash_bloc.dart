import 'package:ant_time_flutter/di/image_header.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:bloc/bloc.dart';
import 'package:domain/repository/secure_storage_repository.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required SharedPreferencesRepository secureStorage,
  })  : _secureStorage = secureStorage,
        super(const SplashState(status: SplashStatus.loading)) {
    on<SplashEvent>((event, emit) async {
      final token = await _secureStorage.getApiToken();
      if (token != null) {
        ImageHeaders.headers = {AppConst.tokenHeader: token};
        emit(const SplashState(status: SplashStatus.authorized));
      } else {
        emit(const SplashState(status: SplashStatus.unauthorized));
      }
    });
  }

  final SharedPreferencesRepository _secureStorage;
}
