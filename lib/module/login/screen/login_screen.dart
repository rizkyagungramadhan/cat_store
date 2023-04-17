import 'package:cat_store/common/app_assets.dart';
import 'package:cat_store/common/app_text_form_field.dart';
import 'package:cat_store/common/widgets/app_button.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/login/login_view_model.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_gradient.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<LoginViewModel>();

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      builder: (context, _) {
        final isPasswordVisible = context.select(
          (LoginViewModel vm) => vm.presentation.isPasswordVisible,
        );
        final isLoading = context.select(
          (LoginViewModel vm) => vm.presentation.isLoading,
        );
        final isLoadingRegisteredUsers = context.select(
          (LoginViewModel vm) => vm.presentation.isLoadingRegisteredUsers,
        );

        return Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: AppGradient.verticalWhiteToGray,
              ),
              padding: const EdgeInsets.all(AppDimen.paddingExtraLarge3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.appLogo,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: AppDimen.paddingExtraLarge,
                    ),
                    padding: const EdgeInsets.all(AppDimen.paddingExtraLarge2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 0.5,
                            blurRadius: AppDimen.paddingMedium)
                      ],
                      borderRadius:
                          BorderRadius.circular(AppDimen.radiusMedium),
                    ),
                    child: Form(
                      key: viewModel.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Username section
                          Text(
                            'Username',
                            maxLines: 1,
                            style: AppTextStyle.regular(),
                          ),
                          const SizedBox(height: AppDimen.paddingMedium),
                          AppTextFormField(
                            controller: viewModel.txUserName,
                            maxLines: 1,
                            placeholder: 'myAwesomeUsername',
                            validator: (text) => text?.validateField(
                              fieldName: 'Username',
                            ),
                          ),
                          const SizedBox(height: AppDimen.paddingMedium),

                          ///Password section
                          const SizedBox(height: AppDimen.paddingMedium),
                          Text(
                            'Password',
                            maxLines: 1,
                            style: AppTextStyle.regular(),
                          ),
                          const SizedBox(height: AppDimen.paddingMedium),
                          AppTextFormField(
                            controller: viewModel.txPassword,
                            placeholder: '******',
                            validator: (text) =>
                                text.validateField(fieldName: 'Password'),
                            maxLines: 1,
                            obscureText: !isPasswordVisible,
                            suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.togglePasswordVisibility();
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimen.paddingMedium),

                          ///Button section
                          const SizedBox(height: AppDimen.paddingLarge),
                          Center(
                            child: AppButton(
                              onPressed:
                                  isLoading ? () {} : () => viewModel.login(),
                              textButton: 'Login',
                              isLoading: isLoading,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Forgot your account?', style: AppTextStyle.light()),
                      const SizedBox(width: AppDimen.paddingExtraSmall),
                      AnimatedSwitcher(
                        duration: Duration.zero,
                        child: isLoadingRegisteredUsers
                            ? const SizedBox(
                                width: AppDimen.sizeLoadingIndicator / 4,
                                height: AppDimen.sizeLoadingIndicator / 4,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : InkWell(
                                onTap: viewModel.showAllRegisteredUsers,
                                child: Text(
                                  'Choose one from here',
                                  style: AppTextStyle.hyperLink(
                                    size: AppDimen.fontMedium,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
