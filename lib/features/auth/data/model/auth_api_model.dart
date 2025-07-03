import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;

  final String name;
  final String email;
  final String password;
  final String? role;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuthApiModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      password: password,
      role: role ?? 'user',
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AuthApiModel.fromEntity(UserEntity entity) {
    return AuthApiModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: entity.password,
      role: entity.role,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        role,
        createdAt,
        updatedAt,
      ];
}
