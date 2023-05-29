import 'package:ant_time_flutter/models/issue_model.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class FavoriteUseCase {
  FavoriteUseCase({
    required FavoritesRepository favoritesRepository,
    required IssuesRepository issuesRepository,
  })  : _favoritesRepository = favoritesRepository,
        _issuesRepository = issuesRepository;

  final FavoritesRepository _favoritesRepository;

  final IssuesRepository _issuesRepository;

  Future<List<IssueModel>> getFavoriteTasks() async {
    final favoritesTasks = _favoritesRepository.getFavoriteTasks();
    final String separatedTasks = favoritesTasks.join(',');
    final tasks = await _issuesRepository
        .getIssuesByIds(
          ids: separatedTasks,
        )
        .then(
          (value) => value.issues.map((e) => IssueModel.mapToModel(e, favorite: true)).toList(),
        );

    return tasks;
  }
}
