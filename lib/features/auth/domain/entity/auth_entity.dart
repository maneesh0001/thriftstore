// features/auth/domain/entity/auth_entity.dart
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String email;
  final String password;
  final String? role; // Assuming role is part of your authentication entity

  const AuthEntity({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    this.role,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        password,
        role,
      ];
}