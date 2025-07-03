import 'package:flutter/material.dart';

@immutable
sealed class SignupEvent {}

class RegisterAccountEvent extends SignupEvent {
  final BuildContext context;
  final String email;
  final String fullName;
  final String password;
  final String? role;

  RegisterAccountEvent({
    required this.context,
    required this.email,
    required this.fullName,
    required this.password,
    this.role,
  });
}

class NavigateToLoginEvent extends SignupEvent {
  final BuildContext context;

  NavigateToLoginEvent({required this.context});
}
