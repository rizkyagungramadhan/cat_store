import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final String textButton;
  final bool isLoading;
  final double? width;

  const AppButton({
    required this.onPressed,
    required this.textButton,
    this.isLoading = false,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.4,
      child: CupertinoButton(
        onPressed: isLoading ? null : onPressed,
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: AppDimen.paddingMedium,
        ),
        color: AppColor.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimen.radiusMedium),
        ),
        child: isLoading
            ? const SizedBox(
                width: AppDimen.paddingLarge,
                height: AppDimen.paddingLarge,
                child: CircularProgressIndicator(
                  color: AppColor.accent,
                  strokeWidth: 2,
                ),
              )
            : Text(
                textButton,
                maxLines: 1,
                style: AppTextStyle.regular(
                  size: AppDimen.fontLarge,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
