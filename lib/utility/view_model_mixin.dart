import 'package:cat_store/common/widgets/dialog/app_dialog.dart';
import 'package:cat_store/common/widgets/dialog/dialog_type.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin ViewModelMixin {
  void showInformationDialog(message, {Function()? onPressed}) {
    final currentContext =
        serviceLocator<AppRouter>().rootNavigationKey.currentContext;

    final type = onPressed != null
        ? DialogType.informationWithAction
        : DialogType.information;

    if (currentContext is BuildContext) {
      showDialog(
        context: currentContext,
        builder: (_) {
          return AppDialog(
            title: type.title,
            message: message.toString(),
            type: type,
            onPressed: onPressed,
          );
        },
      );
    }
  }

  void showPopUpDialog({required Widget child}) {
    final currentContext =
        serviceLocator<AppRouter>().rootNavigationKey.currentContext;

    if (currentContext is BuildContext) {
      showDialog(
        context: currentContext,
        builder: (_) => child,
      );
    }
  }

  void logError(dynamic error) {
    if (kDebugMode) {
      print(error);
    }
  }
}
