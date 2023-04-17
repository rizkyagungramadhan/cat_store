import 'package:cat_store/common/widgets/dialog/dialog_type.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/build_context_ext.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String message;
  final Function()? onPressed;
  final Widget? contentWidget;
  final DialogType type;
  final String? positiveTextButton;
  final String? negativeTextButton;

  const AppDialog({
    Key? key,
    this.title,
    required this.message,
    this.onPressed,
    this.contentWidget,
    this.positiveTextButton,
    this.negativeTextButton,
    this.type = DialogType.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light(),
        child: CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              (title ?? type.title).asTitleCase,
              maxLines: 1,
              style: AppTextStyle.bold(),
            ),
          ),
          content: contentWidget ??
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyle.regular(),
              ),
          actions: _dialogButtons(
            context,
            type: type,
            onPressed: onPressed,
            positiveTextButton: positiveTextButton,
            negativeTextButton: negativeTextButton,
          ),
        ));
  }
}

List<Widget> _dialogButtons(
  BuildContext context, {
  Function()? onPressed,
  required DialogType type,
  String? positiveTextButton,
  String? negativeTextButton,
}) {
  var actionButtons = <Widget>[
    CupertinoDialogAction(
      child: Text(
        'Ok',
        maxLines: 1,
        style: AppTextStyle.regular(color: AppColor.primary),
      ),
      onPressed: () => context.dismiss(),
    ),
  ];

  switch (type) {
    case DialogType.informationWithAction:
      actionButtons.clear();
      actionButtons.add(
        CupertinoDialogAction(
          child: Text(
            'Ok',
            maxLines: 1,
            style: AppTextStyle.regular(color: AppColor.primary),
          ),
          onPressed: () async {
            context.dismiss();
            await onPressed?.call();
          },
        ),
      );
      return actionButtons;
    case DialogType.warning:
      actionButtons.insert(
        0,
        CupertinoDialogAction(
          child: Text('Retry',
              maxLines: 1,
              style: AppTextStyle.regular(color: AppColor.primary)),
          onPressed: () async {
            context.dismiss();
            await onPressed?.call();
          },
        ),
      );
      return actionButtons;
    case DialogType.confirmation:
      actionButtons
        ..clear()
        ..addAll([
          CupertinoDialogAction(
            onPressed: onPressed != null
                ? () async {
                    await Future.delayed(const Duration(milliseconds: 200),
                        () => context.dismiss());
                    onPressed.call();
                  }
                : () {},
            child: Text(
              positiveTextButton ?? 'Yes',
              maxLines: 1,
              style: AppTextStyle.regular(color: AppColor.primary),
            ),
          ),
          CupertinoDialogAction(
            child: Text(
              negativeTextButton ?? 'No',
              maxLines: 1,
              style: AppTextStyle.regular(
                color: CupertinoColors.destructiveRed,
              ),
            ),
            onPressed: () => context.dismiss(),
          ),
        ]);
      return actionButtons;
    default:
      return actionButtons;
  }
}
