import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/core/common/snackbar.dart';
import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final AuthRegisterUsecase _authRegisterUsecase;

  SignupViewModel(this._authRegisterUsecase) : super(SignupState.initial()) {
    on<RegisterAccountEvent>(_onSubmitted);
    on<NavigateToLoginEvent>(_navigateToLogin);
  }

  void _navigateToLogin(
      NavigateToLoginEvent event, Emitter<SignupState> emit) {
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceLocator<LoginViewModel>(),
            child: LoginPage(),
          ),
        ),
      );
    }
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
        showMySnackBar(context: event.context, message: "Registeration failed: ${failure.message}",color: Colors.redAccent); 
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(context: event.context, message: "Registeration successful");
      },
    );
  }
}
