import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id; // unique identifier from backend
  final String name;
  final String email;
  final String password;
  final String? role;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['userId'] ?? json['id'],    // match your backend key
      name: json['name'] ?? '',        // 'name' from your JSON
      email: json['email'] ?? '',
      password: '', // you likely don't get password from backend, so set empty
      role: json['role'] ?? '',
    );
  }

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [id, name, email, password, role];
}
