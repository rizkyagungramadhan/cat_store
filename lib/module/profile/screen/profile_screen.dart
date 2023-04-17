import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_store/api/user/model/user_response.dart';
import 'package:cat_store/common/app_assets.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/profile/profile_view_model.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_gradient.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<ProfileViewModel>();

    return ChangeNotifierProvider(
      create: (_) => viewModel..init(),
      builder: (context, _) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: AppDimen.sizeHeaderPhoto / 2),
            margin: const EdgeInsets.all(AppDimen.paddingMedium),
            child: Consumer<ProfileViewModel>(
              builder: (context, model, _) {
                if (model.presentation.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (model.presentation.user is! UserResponse) {
                  return Center(
                    child: Text(
                      'Your data cannot be found',
                      style: AppTextStyle.regular(),
                    ),
                  );
                }

                final userLogin = model.presentation.user as UserResponse;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _UserContainer(userLogin: userLogin),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _UserContainer extends StatelessWidget {
  final UserResponse userLogin;

  const _UserContainer({Key? key, required this.userLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget defaultUserPhoto = ClipRRect(
      borderRadius: BorderRadius.circular(AppDimen.sizeHeaderPhoto / 2),
      child: Image.asset(
        AppAssets.defaultUserPhoto,
        alignment: Alignment.center,
        width: AppDimen.sizeHeaderPhoto,
        height: AppDimen.sizeHeaderPhoto,
        fit: BoxFit.cover,
      ),
    );

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: AppDimen.paddingMedium),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimen.radiusLarge),
            ),
            gradient: AppGradient.verticalGrayDarkToLight,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppDimen.paddingExtraLarge5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.paddingMedium,
                ),
                child: Text(
                  userLogin.fullName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.regular(
                    size: AppDimen.fontLarge,
                    color: Colors.black54,
                  ),
                ),
              ),
              Text(
                '@${userLogin.username.toLowerCase()}',
                style: AppTextStyle.bold(color: AppColor.accent),
              ),
              const SizedBox(height: AppDimen.paddingLarge),
              const Divider(
                height: 0.25,
                color: Colors.black45,
              ),
              InkWell(
                onTap: () {
                  final viewModel = context.read<ProfileViewModel>();
                  viewModel.showConfirmationDialog(
                    'Are you sure want to logout?',
                    onPressed: () => viewModel.logout(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(AppDimen.paddingMedium),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(AppDimen.radiusLarge),
                    ),
                    color: AppColor.grayDark.withOpacity(0.35),
                  ),
                  child: Center(
                    child: Text(
                      'Logout',
                      style: AppTextStyle.regular(color: AppColor.red),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(
            0.0,
            -(AppDimen.sizeHeaderPhoto / 2),
            0.0,
          ),
          child: userLogin.imageUrl.isNotNullOrEmpty
              ? CachedNetworkImage(
                  width: AppDimen.sizeHeaderPhoto,
                  height: AppDimen.sizeHeaderPhoto,
                  imageUrl: userLogin.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: AppDimen.sizeHeaderPhoto,
                    height: AppDimen.sizeHeaderPhoto,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.grayDark),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (_, __) => const CircularProgressIndicator(),
                  errorWidget: (_, __, ___) => defaultUserPhoto,
                )
              : defaultUserPhoto,
        ),
        Container(
          alignment: Alignment.centerRight,
          transform: Matrix4.translationValues(
            0.0,
            -(AppDimen.sizeHeaderPhoto / 2),
            0.0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: AppDimen.paddingExtraLarge,
              top: AppDimen.sizeHeaderPhoto - AppDimen.paddingExtraLarge,
            ),
            child: Icon(
              userLogin.gender.toLowerCase() == 'male'
                  ? Icons.male
                  : Icons.female,
            ),
          ),
        )
      ],
    );
  }
}
