part of 'splash_bloc.dart';

enum SplashStatus { loading, authorized, unauthorized }

extension SplashStatusExtension on SplashStatus {
  bool get isUnauthorized => this == SplashStatus.unauthorized;

  bool get isAuthorized => this == SplashStatus.authorized;

  bool get isLoading => this == SplashStatus.loading;
}

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
