import 'package:dio/dio.dart';
import 'package:domain/entities/checklist_entity.dart';
import 'package:domain/entities/pagination_checklist_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'checklist_repository.g.dart';

@RestApi()
abstract class ChecklistRepository {
  factory ChecklistRepository(Dio dio) = _ChecklistRepository;

  @GET('/issues/{issueId}/checklists.json')
  Future<PaginationChecklistEntity> getChecklist({
    @Path() required int issueId,
  });

  @PUT('/checklists/{checklistId}.json')
  Future<void> updateChecklist({
    @Path() required int checklistId,
    @Body() required ChecklistEntity checklist,
  });
}
