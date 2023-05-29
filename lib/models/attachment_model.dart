import 'package:ant_time_flutter/resources/resources.dart';
import 'package:domain/domain.dart';

class AttachmentModel {
  int id;
  String filename;
  String description;
  FileType contentType;
  String contentUrl;
  String createdOn;
  String? thumbnailUrl;

  AttachmentModel({
    required this.id,
    required this.filename,
    required this.description,
    required this.contentType,
    required this.contentUrl,
    required this.createdOn,
    this.thumbnailUrl,
  });

  factory AttachmentModel.mapToModel(AttachmentEntity entity) {
    return AttachmentModel(
      description: entity.description,
      createdOn: entity.createdOn,
      filename: entity.filename,
      contentType: _parseMimeType(entity.contentType),
      contentUrl: entity.contentUrl,
      id: entity.id,
      thumbnailUrl: entity.thumbnailUrl,
    );
  }

  static FileType _parseMimeType(String? mimeType) {
    if (mimeType?.contains(AppConst.video) ?? false) {
      return FileType.video;
    } else if (mimeType?.contains(AppConst.image) ?? false) {
      return FileType.image;
    } else if (mimeType?.contains(AppConst.text) ?? false) {
      return FileType.txt;
    } else {
      return FileType.unknown;
    }
  }
}
