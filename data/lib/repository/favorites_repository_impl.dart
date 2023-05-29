import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final SharedPreferences _sharedPreferences;

  FavoritesRepositoryImpl(this._sharedPreferences);

  final String _favorites = 'favorites';
  final String _history = 'history';

  @override
  List<String> getFavoriteTasks() {
    return _sharedPreferences.getStringList(_favorites) ?? [];
  }

  @override
  List<String> getHistoryTasks() {
    return _sharedPreferences.getStringList(_history) ?? [];
  }

  @override
  Future<void> removeFavoriteTask({required String taskId}) async {
    List<String> tasks = getFavoriteTasks();
    tasks.remove(taskId);
    await _sharedPreferences.setStringList(_favorites, tasks);
  }

  @override
  Future<void> saveFavoriteTask({required String taskId}) async{
    List<String> tasks = getFavoriteTasks();
    tasks.add(taskId);
    await _sharedPreferences.setStringList(_favorites, tasks);
  }
  @override
  Future<void> saveHistoryTask({required String taskId}) async{
    List<String> tasks = getFavoriteTasks();
    tasks.add(taskId);

    await _sharedPreferences.setStringList(_history, tasks.toSet().toList());
  }

  @override
  Future<void> clearData() async{
    await _sharedPreferences.clear();
  }
}
