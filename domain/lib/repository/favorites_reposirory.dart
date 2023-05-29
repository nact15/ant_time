abstract class FavoritesRepository {
  Future<void> saveFavoriteTask({required String taskId});

  Future<void> removeFavoriteTask({required String taskId});

  List<String> getFavoriteTasks();

  Future<void> saveHistoryTask({required String taskId});

  List<String> getHistoryTasks();

  Future<void> clearData();
}
