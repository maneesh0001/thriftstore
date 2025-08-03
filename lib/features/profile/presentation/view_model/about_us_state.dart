import 'package:equatable/equatable.dart';

abstract class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final String aboutText;
  final String missionText;
  final String valuesText;

  const AboutLoaded({
    required this.aboutText,
    required this.missionText,
    required this.valuesText,
  });

  @override
  List<Object> get props => [aboutText, missionText, valuesText];
}

class AboutError extends AboutState {
  final String message;

  const AboutError(this.message);

  @override
  List<Object> get props => [message];
}