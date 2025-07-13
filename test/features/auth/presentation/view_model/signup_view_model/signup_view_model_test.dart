// Import necessary packages for testing
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
 
// Import the classes to be tested and their dependencies

import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
 
// --- Mocktail Setup ---
// Create mock classes for dependencies
class MockAuthRegisterUsecase extends Mock implements AuthRegisterUsecase {}
class MockBuildContext extends Mock implements BuildContext {}
 
// Create a mock for the snackbar function signature
class MockShowSnackBar extends Mock {
  void call({
    required BuildContext context,
    required String message,
    Color? color,
  });
}
 
// Create Fake classes for custom types used as arguments in mocks
class FakeAuthRegisterParams extends Fake implements AuthRegisterParams {}
class FakeBuildContext extends Fake implements BuildContext {}
// --- End Mocktail Setup ---
 
void main() {
  // Register fallback values for any custom types used in mock calls
  setUpAll(() {
    registerFallbackValue(FakeAuthRegisterParams());
    registerFallbackValue(FakeBuildContext());
  });
 
  // Group tests for the SignupViewModel
  group('SignupViewModel', () {
    // Declare variables to be used in the tests
    late MockAuthRegisterUsecase mockAuthRegisterUsecase;
    late SignupViewModel signupViewModel;
    late MockBuildContext mockBuildContext;
    late MockShowSnackBar mockShowSnackBar;
 
    // Test data
    const tFullName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tRole = 'user';
    final tRegisterParams = AuthRegisterParams(
      name: tFullName,
      email: tEmail,
      password: tPassword,
      role: tRole,
    );
 
    // This runs before each test
    setUp(() {
      // Initialize the mocks
      mockAuthRegisterUsecase = MockAuthRegisterUsecase();
      mockBuildContext = MockBuildContext();
      mockShowSnackBar = MockShowSnackBar();
     
      // Instantiate the ViewModel with the mocked usecase and snackbar function
      signupViewModel = SignupViewModel(
        mockAuthRegisterUsecase,
        showSnackbar: mockShowSnackBar.call,
      );
    });
 
    // This runs after each test to ensure a clean state
    tearDown(() {
      signupViewModel.close();
    });
 
    // Test the initial state of the ViewModel
    test('initial state is correct', () {
      expect(signupViewModel.state, SignupState.initial());
    });
 
    // Test case for a successful registration
    blocTest<SignupViewModel, SignupState>(
      'emits [isLoading: true, isSuccess: true] when registration is successful',
      // Arrange: Set up the mock to return a successful result
      setUp: () {
        when(() => mockAuthRegisterUsecase(any()))
            .thenAnswer((_) async => const Right(null)); // Assuming success returns void/null
       
        // Stub the snackbar call
        when(() => mockShowSnackBar.call(
          context: any(named: 'context'),
          message: any(named: 'message'),
          color: any(named: 'color'),
        )).thenAnswer((_) {});
      },
      // Act: Build the ViewModel and add the RegisterAccountEvent
      build: () => signupViewModel,
      act: (bloc) => bloc.add(RegisterAccountEvent(
        fullName: tFullName,
        email: tEmail,
        password: tPassword,
        role: tRole,
        context: mockBuildContext,
      )),
      // Assert: Expect the state to change from loading to success
      expect: () => [
        SignupState(isLoading: true, isSuccess: false),
        SignupState(isLoading: false, isSuccess: true),
      ],
      // Verify: Ensure the usecase and snackbar were called as expected
      verify: (_) {
        verify(() => mockAuthRegisterUsecase(tRegisterParams)).called(1);
        verify(() => mockShowSnackBar.call(
          context: mockBuildContext,
          message: 'Registeration successful',
          color: null,
        )).called(1);
        verifyNoMoreInteractions(mockAuthRegisterUsecase);
        verifyNoMoreInteractions(mockShowSnackBar);
      },
    );
 
    // Test case for a failed registration
    blocTest<SignupViewModel, SignupState>(
      'emits [isLoading: true, isSuccess: false] when registration fails',
      // Arrange: Set up the mock to return a failure
      setUp: () {
        const failureMessage = 'Email already in use';
        when(() => mockAuthRegisterUsecase(any()))
            .thenAnswer((_) async => Left(ApiFailure(message: failureMessage)));
       
        // Stub the snackbar call
        when(() => mockShowSnackBar.call(
          context: any(named: 'context'),
          message: any(named: 'message'),
          color: any(named: 'color'),
        )).thenAnswer((_) {});
      },
      // Act: Build the ViewModel and add the RegisterAccountEvent
      build: () => signupViewModel,
      act: (bloc) => bloc.add(RegisterAccountEvent(
        fullName: tFullName,
        email: tEmail,
        password: tPassword,
        role: tRole,
        context: mockBuildContext,
      )),
      // Assert: Expect the state to change from loading back to the initial error state
      expect: () => [
        SignupState(isLoading: true, isSuccess: false),
        SignupState(isLoading: false, isSuccess: false),
      ],
      // Verify: Ensure the usecase and snackbar (with error message) were called
      verify: (_) {
        const failureMessage = 'Email already in use';
        verify(() => mockAuthRegisterUsecase(tRegisterParams)).called(1);
        verify(() => mockShowSnackBar.call(
          context: mockBuildContext,
          message: 'Registeration failed: $failureMessage',
          color: Colors.redAccent,
        )).called(1);
        verifyNoMoreInteractions(mockAuthRegisterUsecase);
        verifyNoMoreInteractions(mockShowSnackBar);
      },
    );
  });
}
 