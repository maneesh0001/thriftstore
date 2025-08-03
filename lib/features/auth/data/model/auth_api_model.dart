// features/auth/data/model/auth_api_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:thrift_store/features/auth/domain/entity/auth_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart'; // <--- NEW IMPORT

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String name;
  final String email;
  final String password;
  final String? role;

  const AuthApiModel({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    this.role,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // Convert AuthApiModel to AuthEntity
  AuthEntity toAuthEntity() { // <--- RENAMED METHOD
    return AuthEntity(
      userId: userId,
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }

  // Convert UserEntity to AuthApiModel for account creation (e.g., registration)
  factory AuthApiModel.fromUserEntity(UserEntity entity) { // <--- NEW FACTORY CONSTRUCTOR
    return AuthApiModel(
      userId: entity.id, // Map UserEntity's 'id' to AuthApiModel's 'userId'
      name: entity.name,
      email: entity.email,
      password: entity.password,
      role: entity.role,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        password,
        role,
      ];
}