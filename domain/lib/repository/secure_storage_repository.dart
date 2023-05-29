abstract class SharedPreferencesRepository {
  Future<void> saveApiToken({
    required String token,
  });

  String? getApiToken();

  Future<void> deleteApiToken();

  Future<void> setIsActiveEaster(bool isActive);

  bool getIsActiveEaster();

  bool getIsDark();

  Future<void> setIsDark(bool isDark);
}
