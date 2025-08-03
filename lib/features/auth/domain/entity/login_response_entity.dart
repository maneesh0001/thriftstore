



import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
class LoginResponse {
  final String token;
  final UserEntity user;

  LoginResponse({
    required this.token,
    required this.user, required String userId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: UserEntity.fromJson(json['user']), userId: '',
    );
  }
}
