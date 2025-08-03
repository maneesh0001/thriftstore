import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/core/common/snackbar.dart';
import 'package:thrift_store/features/auth/domain/use_case/update_user_usecase.dart';

part 'my_information_event.dart';
part 'my_information_state.dart';

class MyInformationBloc extends Bloc<MyInformationEvent, MyInformationState> {
  final UpdateUserUsecase _updateUserUsecase;

  MyInformationBloc({
    required UpdateUserUsecase updateUserUsecase,
  })  : _updateUserUsecase = updateUserUsecase,
        super(MyInformationState.initial()) {
    on<UpdateUserEvent>(_onUpdateUser);
  }

  void _onUpdateUser(
    UpdateUserEvent event,
    Emitter<MyInformationState> emit,
  ) async {
    if (event.name.isEmpty || event.email.isEmpty || event.phone.isEmpty) {
      event.onFailure('All fields must be filled.');
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
        .hasMatch(event.email)) {
      event.onFailure('Invalid email format.');
      return;
    }

    if (event.phone.length <= 9) {
      event.onFailure('Phone number must be greater than 9 digits.');
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await _updateUserUsecase.call(UpdateUserParams(
      name: event.name,
      email: event.email,
      phone: event.phone,
      age: event.age,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context,
            message: "User information updated successfully");
        event.onSuccess();
      },
    );
  }
}
