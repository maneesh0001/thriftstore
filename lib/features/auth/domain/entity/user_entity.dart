import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String email;
  final String name;
  final String password;
  final String phoneNumber;

  const UserEntity({
    this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, email, name, password, phoneNumber];
}
