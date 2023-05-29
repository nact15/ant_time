import 'dart:io';

import 'package:domain/repository/secure_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  final SharedPreferences _sharePreferences;

  SharedPreferencesRepositoryImpl(
    SharedPreferences sharedPreferences,
  ) : _sharePreferences = sharedPreferences;

  @override
  String? getApiToken() {
    return _sharePreferences.getString('api_token');
  }

  @override
  Future<void> saveApiToken({required String token}) async {
    await _sharePreferences.setString('api_token', token);
  }

  @override
  Future<void> deleteApiToken() async {
    await _sharePreferences.remove('api_token');
  }

  @override
  bool getIsActiveEaster() {
    return _sharePreferences.getBool('is_active_easter') ?? true;
  }

  @override
  Future<void> setIsActiveEaster(bool isActive) async {
    await _sharePreferences.setBool('is_active_easter', isActive);
  }

  @override
  bool getIsDark() {
    return _sharePreferences.getBool('is_dark') ?? false;
  }

  @override
  Future<void> setIsDark(bool isDark) async {
    await _sharePreferences.setBool('is_dark', isDark);
  }
}
