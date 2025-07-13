import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/core/common/snackbar.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';
class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final AuthRegisterUsecase _authRegisterUsecase;
   final void Function({
    required BuildContext context,
    required String message,
    Color? color,
  }) _showSnackbar;
  SignupViewModel(this._authRegisterUsecase, {
    void Function({
    required BuildContext context,
    required String message,
    Color? color,
  })? showSnackbar
  }) : _showSnackbar = showSnackbar ?? showMySnackBar, super(SignupState.initial()) {
    on<RegisterAccountEvent>(_onSubmitted);
  }
  Future<void> _onSubmitted(
      RegisterAccountEvent event, Emitter<SignupState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRegisterUsecase(AuthRegisterParams(
      email: event.email,
      name: event.fullName,
      password: event.password,
      role: event.role,
    ));
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        _showSnackbar(context: event.context, message: "Registeration failed: ${failure.message}",color: Colors.redAccent);
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        _showSnackbar(context: event.context, message: "Registeration successful");
      },
    );
  }
}