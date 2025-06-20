import 'package:flutter/material.dart';
 
@immutable
sealed class LoginEvent {}
 
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

class NavigateToDashboardEvent extends LoginEvent {
  final BuildContext context;
  
  NavigateToDashboardEvent({ required this.context });
}
 