import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/resources/resources.dart';

// ignore: prefer-match-file-name
extension MimeTypeExtension on FileType {
  bool get isImage => this == FileType.image;
}

extension ErrorTypeExtension on ErrorType {
  String getMessage(AppLocalizations localizations) {
    switch (this) {
      case ErrorType.noInternetConnection:
        return localizations.errorNoInternetConnection;
      case ErrorType.unauthorized:
        return localizations.errorForbidden;
      case ErrorType.issueNotFound:
        return localizations.issueNotFound;
      case ErrorType.unknown:
        return localizations.errorSomethingWentWrong;
    }
  }
}

extension BaseStatusExtension on BaseStatus {
  String getDropdownHint(AppLocalizations localizations) {
    if (this is LoadingStatus) {
      return localizations.loading;
    } else if (this is ErrorStatus) {
      return localizations.errorSomethingWentWrong;
    } else {
      return localizations.selectFromList;
    }
  }

  String getSearchProjectHint(AppLocalizations localizations) {
    if (this is LoadingStatus) {
      return localizations.loading;
    } else if (this is ErrorStatus) {
      return localizations.errorSomethingWentWrong;
    } else {
      return localizations.enterProjectName ;
    }
  }
}
