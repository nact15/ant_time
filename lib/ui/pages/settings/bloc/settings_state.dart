part of 'settings_bloc.dart';

enum SettingsStatus { initial, logout, switchTheme }

extension SettingsStatusExtension on SettingsStatus {
  bool get isLogout => this == SettingsStatus.logout;

  bool get isSwitchTheme => this == SettingsStatus.switchTheme;
}

class SettingsState extends Equatable {
  final SettingsStatus status;
  final bool isActiveEaster;
  final bool isDarkTheme;

  SettingsState({
    required this.status,
    this.isActiveEaster = false,
    this.isDarkTheme = false,
  });

  @override
  List<Object?> get props => [status, isActiveEaster, isDarkTheme];

  SettingsState copyWith({
    SettingsStatus? status,
    bool? isActiveEaster,
    bool? isDarkTheme,
  }) {
    return SettingsState(
      status: status ?? SettingsStatus.initial,
      isActiveEaster: isActiveEaster ?? this.isActiveEaster,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
