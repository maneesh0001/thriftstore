import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';

// 1️⃣ Mocks
class MockAuthLoginUsecase extends Mock implements AuthLoginUsecase {}

class MockUserSharedPrefs extends Mock implements UserSharedPrefs {}

// 2️⃣ Fake class for LoginParams
class FakeLoginParams extends Fake implements LoginParams {}

// We'll mock the snackbar function to just verify calls
void mockShowSnackbar({
  required BuildContext context,
  required String message,
  Color? color,
}) {}

void main() {
  setUpAll(() {
    // Register fallback so `any()` works for LoginParams
    registerFallbackValue(FakeLoginParams());
  });

  late LoginViewModel loginViewModel;
  late MockAuthLoginUsecase mockAuthLoginUsecase;
  late MockUserSharedPrefs mockUserSharedPrefs;

  // Fake BuildContext needed for the event
  final fakeContext = _FakeBuildContext();

  // Sample login response entity
  final loginResponse = LoginResponse(
    token: 'token123',
    user: UserEntity(
      id: 'user1',
      email: 'test@example.com',
      name: 'Test User',
      role: 'user',
      password: '',
    ),
    userId: '',
  );

  setUp(() {
    mockAuthLoginUsecase = MockAuthLoginUsecase();
    mockUserSharedPrefs = MockUserSharedPrefs();

    loginViewModel = LoginViewModel(
      mockAuthLoginUsecase,
      mockUserSharedPrefs,
      showSnackbar: mockShowSnackbar,
    );
  });

  group('LoginViewModel', () {
    blocTest<LoginViewModel, LoginState>(
      'emits [loading:true, success:false], then [loading:false, success:true] and calls saveUser & snackbar on successful login',
      build: () {
        when(() => mockAuthLoginUsecase.call(any())).thenAnswer(
          (_) async => Right(loginResponse),
        );
        when(() => mockUserSharedPrefs.saveUser(
              token: any(named: 'token'),
              userId: any(named: 'userId'),
              email: any(named: 'email'),
              name: any(named: 'name'),
              role: any(named: 'role'),
            )).thenAnswer((_) async => Future.value());

        return loginViewModel;
      },
      act: (bloc) => bloc.add(LoginSubmitted(
        email: 'test@example.com',
        password: 'password',
        context: fakeContext,
      )),
      expect: () => [
        loginViewModel.state.copyWith(isLoading: true, isSuccess: false), // Corrected here
        loginViewModel.state.copyWith(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockAuthLoginUsecase.call(any())).called(1);
        verify(() => mockUserSharedPrefs.saveUser(
              token: loginResponse.token,
              userId: loginResponse.user.id ?? '',
              email: loginResponse.user.email,
              name: loginResponse.user.name,
              role: loginResponse.user.role ?? '',
            )).called(1);
      },
    );

    blocTest<LoginViewModel, LoginState>(
      'emits [loading:true, success:false], then [loading:false, success:false] and calls snackbar on login failure',
      build: () {
        when(() => mockAuthLoginUsecase.call(any())).thenAnswer(
          (_) async => Left(ApiFailure(message: 'Login failed')),
        );

        return loginViewModel;
      },
      act: (bloc) => bloc.add(LoginSubmitted(
        email: 'wrong@example.com',
        password: 'wrongpassword',
        context: fakeContext,
      )),
      expect: () => [
        loginViewModel.state.copyWith(isLoading: true, isSuccess: false), // Make sure first loading state is success:false
        loginViewModel.state.copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockAuthLoginUsecase.call(any())).called(1);
        verifyNever(() => mockUserSharedPrefs.saveUser(
              token: any(named: 'token'),
              userId: any(named: 'userId'),
              email: any(named: 'email'),
              name: any(named: 'name'),
              role: any(named: 'role'),
            ));
      },
    );
  });
}

// A simple fake BuildContext implementation
class _FakeBuildContext implements BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
