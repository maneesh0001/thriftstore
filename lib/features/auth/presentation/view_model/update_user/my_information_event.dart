part of 'my_information_bloc.dart';

abstract class MyInformationEvent extends Equatable {
  const MyInformationEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends MyInformationEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String phone;
  final int age;
  final Function() onSuccess;
  final Function(String errorMessage) onFailure;

  const UpdateUserEvent({
    required this.context,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  List<Object?> get props => [name, email, phone, age];
}