import 'package:domain/entities/issue_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_issues_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginationIssuesEntity {
  final List<IssueEntity> issues;
  @JsonKey(name: 'total_count')
  final int totalCount;
  final int limit;
  final int offset;

  PaginationIssuesEntity(this.issues, this.totalCount, this.limit, this.offset);

  factory PaginationIssuesEntity.fromJson(Map<String, dynamic> json) =>
      _$PaginationIssuesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationIssuesEntityToJson(this);
}

PaginationIssuesEntity deserializePaginationIssuesEntity(Map<String, dynamic> json) {
  return PaginationIssuesEntity.fromJson(json);
}

Map<String, dynamic> serializePaginationIssuesEntity(IssueEntity object) => object.toJson();
