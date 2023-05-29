import 'package:json_annotation/json_annotation.dart';

part 'attachment_entity.g.dart';

@JsonSerializable()
class AttachmentEntity {
  final int id;
  final String filename;
  final String description;
  @JsonKey(name: 'content_type')
  final String? contentType;
  @JsonKey(name: 'content_url')
  final String contentUrl;
  @JsonKey(name: 'created_on')
  final String createdOn;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;

  AttachmentEntity(
    this.id,
    this.filename,
    this.contentType,
    this.description,
    this.thumbnailUrl,
    this.contentUrl,
    this.createdOn,
  );

  factory AttachmentEntity.fromJson(Map<String, dynamic> json) => _$AttachmentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentEntityToJson(this);
}
