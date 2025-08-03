part of 'my_information_bloc.dart';

class MyInformationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const MyInformationState({
    required this.isLoading,
    required this.isSuccess,
  });

  factory MyInformationState.initial() {
    return const MyInformationState(isLoading: false, isSuccess: false);
  }

  MyInformationState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return MyInformationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}