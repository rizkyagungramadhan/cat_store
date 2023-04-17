import 'package:cat_store/api/user/model/user_credential_response.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/build_context_ext.dart';
import 'package:flutter/material.dart';

class UserListDialog extends StatelessWidget {
  final List<UserCredentialResponse> registeredUsers;
  final Function(UserCredentialResponse) onUserSelected;

  const UserListDialog({
    Key? key,
    required this.registeredUsers,
    required this.onUserSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.all(AppDimen.paddingExtraLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
          color: AppColor.grayLight,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimen.paddingLarge),
              child: Text(
                'Registered Users',
                style: AppTextStyle.regular(),
              ),
            ),
            Expanded(
              child: registeredUsers.isNotEmpty
                  ? ListView(
                      shrinkWrap: true,
                      children: registeredUsers
                          .map(
                            (user) => _RegisteredUserView(
                              user: user,
                              onUserSelected: onUserSelected,
                            ),
                          )
                          .toList(),
                    )
                  : Text(
                      'No data found',
                      style: AppTextStyle.light(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisteredUserView extends StatelessWidget {
  final UserCredentialResponse user;
  final Function(UserCredentialResponse) onUserSelected;

  const _RegisteredUserView({
    Key? key,
    required this.user,
    required this.onUserSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onUserSelected(user);
        context.dismiss();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppDimen.paddingSmall,
          horizontal: AppDimen.paddingLarge,
        ),
        padding: const EdgeInsets.all(AppDimen.paddingMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
          color: AppColor.grayDark,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.username,
              style: AppTextStyle.hyperLink(size: AppDimen.fontMedium),
            ),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              color: AppColor.primary,
            ),
          ],
        ),
      ),
    );
  }
}
