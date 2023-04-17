import 'package:cat_store/module/onboarding/const/onboarding_content.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:flutter/material.dart';

class OnBoardingContentView extends StatelessWidget {
  final OnBoardingContent content;

  const OnBoardingContentView({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimen.paddingMedium,
        horizontal: AppDimen.paddingExtraLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            content.image,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: AppDimen.paddingLarge),
          Text(
            content.title,
            style: AppTextStyle.regular(size: AppDimen.fontMediumLarge),
          ),
          const SizedBox(height: AppDimen.paddingSmall),
          Text(
            content.description,
            style: AppTextStyle.light(),
          ),
        ],
      ),
    );
  }
}
