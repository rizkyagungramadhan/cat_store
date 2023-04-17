import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  @JsonKey(name: 'image')
  final String imageUrl;

  UserResponse(
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.imageUrl,
  );

  String get fullName => '$firstName $lastName';

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
