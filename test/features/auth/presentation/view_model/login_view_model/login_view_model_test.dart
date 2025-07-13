// Import necessary packages for testing
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart'; // Changed from mockito
import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
 
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
 
// --- Mocktail Setup ---
// Create mock classes for dependencies
class MockAuthLoginUsecase extends Mock implements AuthLoginUsecase {}
class MockBuildContext extends Mock implements BuildContext {}
 
// Create a mock for the snackbar function signature
class MockShowSnackBar extends Mock {
  void call({
    required BuildContext context,
    required String message,
    Color? color,
  });
}
 
// Create a Fake for custom types used as arguments in mocks
class FakeLoginParams extends Fake implements LoginParams {}
class FakeBuildContext extends Fake implements BuildContext {} // Can also use a Fake
// --- End Mocktail Setup ---
 
void main() {
  // Register fallback values for any custom types used in mock calls
  // This is required by mocktail for non-standard types.
  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
    // FIX: Register a fallback value for BuildContext to resolve the error.
    registerFallbackValue(FakeBuildContext());
  });
 
  // Group tests for the LoginViewModel
  group('LoginViewModel', () {
    // Declare variables to be used in the tests
    late MockAuthLoginUsecase mockAuthLoginUsecase;
    late LoginViewModel loginViewModel;
    late MockBuildContext mockBuildContext;
    late MockShowSnackBar mockShowSnackBar;
 
    // Test credentials
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    final tLoginParams = LoginParams(email: tEmail, password: tPassword);
 
    // This runs before each test
    setUp(() {
      // Initialize the mocks
      mockAuthLoginUsecase = MockAuthLoginUsecase();
      mockBuildContext = MockBuildContext();
      mockShowSnackBar = MockShowSnackBar();
     
      // Instantiate the ViewModel with the mocked usecase and snackbar function
      loginViewModel = LoginViewModel(
        mockAuthLoginUsecase,
        showSnackbar: mockShowSnackBar.call,
      );
    });
 
    // This runs after each test to ensure a clean state
    tearDown(() {
      loginViewModel.close();
    });
 
    // Test the initial state of the ViewModel
    test('initial state is correct', () {
      expect(loginViewModel.state, LoginState.initial());
    });
 
    // Test case for a successful login
    blocTest<LoginViewModel, LoginState>(
      'emits [isLoading: true, isSuccess: true] when login is successful',
      // Arrange: Set up the mock to return a successful result
      setUp: () {
        // Use mocktail's `when` syntax for stubbing
        when(() => mockAuthLoginUsecase(any()))
            .thenAnswer((_) async => const Right("")); // Assuming success returns void/null
       
        // Stub the snackbar call since it will be invoked
        when(() => mockShowSnackBar.call(
          context: any(named: 'context'),
          message: any(named: 'message'),
          color: any(named: 'color'),
        )).thenAnswer((_) {});
      },
      // Act: Build the ViewModel and add the LoginSubmitted event
      build: () => loginViewModel,
      act: (bloc) => bloc.add(LoginSubmitted(
        email: tEmail,
        password: tPassword,
        context: mockBuildContext,
      )),
      // Assert: Expect the state to change from loading to success
      expect: () => [
        LoginState(isLoading: true, isSuccess: false),
        LoginState(isLoading: false, isSuccess: true),
      ],
      // Verify: Ensure the usecase and snackbar were called as expected
      verify: (_) {
        // Use mocktail's `verify` syntax
        verify(() => mockAuthLoginUsecase(tLoginParams)).called(1);
        verify(() => mockShowSnackBar.call(
          context: mockBuildContext,
          message: 'Login Successful!',
          color: null, // Default color is null
        )).called(1);
        verifyNoMoreInteractions(mockAuthLoginUsecase);
        verifyNoMoreInteractions(mockShowSnackBar);
      },
    );
 
    // Test case for a failed login
    blocTest<LoginViewModel, LoginState>(
      'emits [isLoading: true, isSuccess: false] when login fails',
      // Arrange: Set up the mock to return a failure
      setUp: () {
        when(() => mockAuthLoginUsecase(any()))
            .thenAnswer((_) async => Left(ApiFailure(message: 'Invalid credentials')));
       
        // Stub the snackbar call
        when(() => mockShowSnackBar.call(
          context: any(named: 'context'),
          message: any(named: 'message'),
          color: any(named: 'color'),
        )).thenAnswer((_) {});
      },
      // Act: Build the ViewModel and add the LoginSubmitted event
      build: () => loginViewModel,
      act: (bloc) => bloc.add(LoginSubmitted(
        email: tEmail,
        password: tPassword,
        context: mockBuildContext,
      )),
      // Assert: Expect the state to change from loading back to the initial error state
      expect: () => [
        LoginState(isLoading: true, isSuccess: false),
        LoginState(isLoading: false, isSuccess: false),
      ],
      // Verify: Ensure the usecase and snackbar (with error message) were called
      verify: (_) {
        verify(() => mockAuthLoginUsecase(tLoginParams)).called(1);
        verify(() => mockShowSnackBar.call(
          context: mockBuildContext,
          message: 'Login Failed!',
          color: Colors.red,
        )).called(1);
        verifyNoMoreInteractions(mockAuthLoginUsecase);
        verifyNoMoreInteractions(mockShowSnackBar);
      },
    );
  });
}
 