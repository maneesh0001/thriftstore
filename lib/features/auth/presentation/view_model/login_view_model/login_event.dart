import 'package:flutter/material.dart';//bloc testing
abstract class LoginEvent {}
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;
  LoginSubmitted({
    required this.email,
    required this.password,
    required this.context
  });
}