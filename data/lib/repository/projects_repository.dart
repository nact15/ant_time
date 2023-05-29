import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

part 'projects_repository.g.dart';

@RestApi()
abstract class ProjectsRepository {
  factory ProjectsRepository(Dio dio) = _ProjectsRepository;

  @GET('/projects.json')
  Future<PaginationProjectEntity> getProjects();
}
