import 'package:cat_store/module/onboarding/screen/widgets/dots_indicator.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/onboarding/const/onboarding_content.dart';
import 'package:cat_store/module/onboarding/onboarding_view_model.dart';
import 'package:cat_store/module/onboarding/screen/widgets/onboarding_content_view.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<OnBoardingViewModel>();

    return ChangeNotifierProvider<OnBoardingViewModel>(
      create: (_) => viewModel,
      builder: (context, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onPanUpdate: (data) {
              context.read<OnBoardingViewModel>().swipe(data);
            },
            child: Stack(
              children: [
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: viewModel.controller,
                  children: OnBoardingContent.values
                      .map(
                        (content) => OnBoardingContentView(
                          key: Key('on-boarding-${content.name}'),
                          content: content,
                        ),
                      )
                      .toList(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DotsIndicator(
                      controller: viewModel.controller,
                      itemCount: OnBoardingContent.values.length,
                      color: AppColor.accent,
                      onPageSelected: (pageIndex) {
                        context
                            .read<OnBoardingViewModel>()
                            .onPageChanged(pageIndex);
                      },
                    ),
                    const SizedBox(height: AppDimen.paddingExtraLarge6),
                    InkWell(
                      onTap: context.read<OnBoardingViewModel>().onCtaPressed,
                      child: AnimatedSwitcher(
                        duration: Duration.zero,
                        child: context.select((OnBoardingViewModel vm) =>
                                vm.presentation.isLastPage)
                            ? Text('Great!', style: AppTextStyle.hyperLink())
                            : Text('Next', style: AppTextStyle.hyperLink()),
                      ),
                    ),
                    const SizedBox(height: AppDimen.paddingExtraLarge5),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
