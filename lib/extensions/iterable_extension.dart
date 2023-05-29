import 'package:ant_time_flutter/models/attachment_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';

extension AttachmentExtension on List<AttachmentModel> {
  String getLinkText(AppLocalizations localizations, AttachmentModel attachment) {
    return '${localizations.attachment} '
        '#${indexOf(attachment) + 1}';
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) where) {
    for (T element in this) {
      if (where(element)) return element;
    }

    return null;
  }

  T? get firstOrNull {
    if (length >= 1) {
      return first;
    }

    return null;
  }
}
