import 'package:cat_store/api/user/model/user_response.dart';
import 'package:equatable/equatable.dart';

class ProfilePresentation extends Equatable {
  final UserResponse? user;
  final bool isLoading;

  const ProfilePresentation({this.user, this.isLoading = false});

  ProfilePresentation copyWith({UserResponse? user, bool? isLoading}) {
    return ProfilePresentation(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, isLoading];
}
