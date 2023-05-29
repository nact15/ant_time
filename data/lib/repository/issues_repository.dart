import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

part 'issues_repository.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class IssuesRepository {
  factory IssuesRepository(Dio dio) = _IssuesRepository;

  @GET('/issues.json?assigned_to_id=me&include=attachments')
  Future<PaginationIssuesEntity> getIssues({
    @Query('limit') required int limit,
    @Query('offset') required int offset,
    @Query('project_id') int? projectId,
    @Query('subject') String? searchSubject,
    @Query('issue_id') String? ids,
  });

  @GET('/issues.json?assigned_to_id=me&include=attachments')
  Future<PaginationIssuesEntity> getIssuesByIds({
    @Query('issue_id') required String ids,
  });

  @GET('/issues/{issueId}.json?include=attachments')
  Future<IssueEntity> getIssueById({
    @Path() required int issueId,
  });

  @POST('/time_entries.json')
  Future<void> pushTime(@Body() TimeEntryEntity timeEntry);

  @GET('/enumerations/time_entry_activities.json')
  Future<ActivitiesEntity> getActivities();
}

