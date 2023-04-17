import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/onboarding/const/onboarding_content.dart';
import 'package:cat_store/module/onboarding/onboarding_presentation.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingViewModel extends ChangeNotifier with ViewModelMixin {
  final controller = PageController();

  OnBoardingPresentation _presentation = const OnBoardingPresentation();

  OnBoardingPresentation get presentation => _presentation;
  final _appRouter = serviceLocator<AppRouter>();

  Future<void> swipe(DragUpdateDetails data) async {
    try {
      final firstPageIndex = OnBoardingContent.values.first.index;
      final lastPageIndex = OnBoardingContent.values.last.index;
      final xOffset = data.delta.dx;

      // Handle right swipe
      if (xOffset > 0) {
        if (controller.page == firstPageIndex) return;
        await controller.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }

      // Handle left swipe
      if (xOffset < 0) {
        if (controller.page == lastPageIndex) return;
        await controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
    } catch (error) {
      logError(error);
    } finally {
      checkIsLastPage();
    }
  }

  Future<void> onPageChanged(int pagePosition) async {
    try {
      await controller.animateToPage(
        pagePosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } catch (error) {
      logError(error);
    } finally {
      checkIsLastPage();
    }
  }

  Future<void> onCtaPressed() async {
    try {
      if (_presentation.isLastPage) {
        return await _appRouter.rootClearAndNavigateTo(Routes.login);
      }

      await controller.animateToPage(
        (controller.page?.round() ?? 0) + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      return checkIsLastPage();
    } catch (error) {
      logError(error);
    }
  }

  void checkIsLastPage() {
    final isLastPage = controller.page == OnBoardingContent.values.last.index;

    _presentation = presentation.copyWith(isLastPage: isLastPage);
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
