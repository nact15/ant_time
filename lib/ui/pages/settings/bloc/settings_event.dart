part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class SettingsLogout extends SettingsEvent {}

class SettingsChangeEasterEgg extends SettingsEvent {
  final bool isActive;

  SettingsChangeEasterEgg(this.isActive);
}

class SettingsChangeThemeMode extends SettingsEvent {
  final bool isDark;

  SettingsChangeThemeMode(this.isDark);
}

class SettingsGetProperties extends SettingsEvent {}

class SettingSetDefaultActivity extends SettingsEvent {
  final ValueModel defaultActivity;

  SettingSetDefaultActivity(this.defaultActivity);
}
