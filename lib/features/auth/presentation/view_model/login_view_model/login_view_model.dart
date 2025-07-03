import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/core/common/snackbar.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:thrift_store/features/dashboard/presentation/view/dashboard_screen.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final AuthLoginUsecase _authLoginUsecase;

  LoginViewModel(this._authLoginUsecase) : super(LoginState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<NavigateToDashboardEvent>(_navigateToDashboard);
    on<NavigateToSignupEvent>(_navigateToSignup);
  }

  void _navigateToDashboard(
      NavigateToDashboardEvent event, Emitter<LoginState> emit) {
    if (event.context.mounted) {
      Navigator.pushReplacement(event.context,
          MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
  }

  void _navigateToSignup(
      NavigateToSignupEvent event, Emitter<LoginState> emit) {
    if (event.context.mounted) {
      Navigator.pushReplacementNamed(event.context, '/dashboard');
    }
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
        showMySnackBar(
            context: event.context,
            message: 'Login Failed!',
            color: Colors.red);
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(context: event.context, message: 'Login Successful!');
        add(NavigateToDashboardEvent(context: event.context));
      },
    );
  }
}
