import 'package:equatable/equatable.dart';

class LoginPresentation extends Equatable {
  final bool isLoading;
  final bool isLoadingRegisteredUsers;
  final bool isPasswordVisible;

  const LoginPresentation({
    this.isLoading = false,
    this.isLoadingRegisteredUsers = false,
    this.isPasswordVisible = false,
  });

  LoginPresentation copyWith({
    bool? isLoading,
    bool? isLoadingRegisteredUsers,
    bool? isPasswordVisible,
  }) {
    return LoginPresentation(
      isLoading: isLoading ?? this.isLoading,
      isLoadingRegisteredUsers:
          isLoadingRegisteredUsers ?? this.isLoadingRegisteredUsers,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isLoadingRegisteredUsers,
        isPasswordVisible,
      ];
}
