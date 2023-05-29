part of 'authorization_bloc.dart';

enum AuthorizationStatus {
  error,
  validationError,
  success,
  initial,
  loading,
}

extension AuthorizationStatusExtension on AuthorizationStatus {
  bool get isLoading => this == AuthorizationStatus.loading;

  bool get isError => this == AuthorizationStatus.error;

  bool get isValidationError => this == AuthorizationStatus.validationError;

  bool get isSuccess => this == AuthorizationStatus.success;
}

class AuthorizationState extends Equatable {
  final AuthorizationStatus status;
  final String? errorTitle;

  const AuthorizationState({
    required this.status,
    this.errorTitle,
  });

  @override
  List<Object?> get props => [status, errorTitle];
}
