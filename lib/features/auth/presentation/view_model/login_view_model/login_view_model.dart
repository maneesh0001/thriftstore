import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/core/common/snackbar.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final AuthLoginUsecase _authLoginUsecase;
   final void Function({
    required BuildContext context,
    required String message,
    Color? color,
  }) _showSnackbar;
 
 
  LoginViewModel(this._authLoginUsecase, {
    void Function({
    required BuildContext context,
    required String message,
    Color? color,
  })? showSnackbar
  }) : _showSnackbar = showSnackbar ?? showMySnackBar, super(LoginState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }
  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(isLoading: true),
    );
    final result = await _authLoginUsecase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        _showSnackbar(
            context: event.context,
            message: 'Login Failed!',
            color: Colors.red);
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        _showSnackbar(context: event.context, message: 'Login Successful!');
      },
    );
  }
}