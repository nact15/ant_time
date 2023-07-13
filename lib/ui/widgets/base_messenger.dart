import 'package:another_flushbar/flushbar.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

enum TypeMessage { error, success }

class BaseMessenger {
  const BaseMessenger._();

  static showBaseMessenger(
    BuildContext context, {
    required String message,
    required TypeMessage typeMessage,
  }) {
    Flushbar(
      icon: Icon(getIcon(typeMessage)),
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      messageText: Text(
        message,
        style: AppTextStyles.messengerStyle.copyWith(
          color: context.theme.reversedColor,
        ),
      ),
      shouldIconPulse: typeMessage == TypeMessage.error,
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: const Duration(seconds: 4),
      backgroundColor: context.theme.backgroundColor,
    ).show(context);
  }

  static IconData getIcon(TypeMessage typeMessage) {
    switch (typeMessage) {
      case TypeMessage.error:
        return AppIcons.errorIcon;

      case TypeMessage.success:
        return AppIcons.successIcon;
    }
  }

  static showErrorMessage(
    BuildContext context, {
    required ErrorType errorType,
  }) {
    return showBaseMessenger(
      context,
      message: errorType.getMessage(context.localizations),
      typeMessage: TypeMessage.error,
    );
  }
}
