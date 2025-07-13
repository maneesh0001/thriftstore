// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:bloc_test/bloc_test.dart';
 
// // Import the classes needed for the test
// import 'package:thrift_store/app/service_locator/service_locator.dart';
// import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
// import 'package:thrift_store/features/auth/presentation/view/signup_page.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_state.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_event.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
 
// // --- Mocktail Setup ---
// // Mock the BLoCs
// class MockLoginViewModel extends MockBloc<LoginEvent, LoginState> implements LoginViewModel {}
// class MockSignupViewModel extends MockBloc<SignupEvent, SignupState> implements SignupViewModel {}
 
// // Mock NavigatorObserver to verify navigation
// class MockNavigatorObserver extends Mock implements NavigatorObserver {}
 
// // Fake classes for custom types
// class FakeLoginEvent extends Fake implements LoginEvent {}
// class FakeRoute extends Fake implements Route<dynamic> {}
// // --- End Mocktail Setup ---

// void main() {
//   late MockLoginViewModel mockLoginViewModel;
//   late MockSignupViewModel mockSignupViewModel;
//   late MockNavigatorObserver mockNavigatorObserver;
 
//   // This runs before each test
//   setUp(() {
//     // Initialize mocks
//     mockLoginViewModel = MockLoginViewModel();
//     mockSignupViewModel = MockSignupViewModel();
//     mockNavigatorObserver = MockNavigatorObserver();
 
//     // Stub the initial states for the BLoCs
//     when(() => mockLoginViewModel.state).thenReturn(LoginState.initial());
//     when(() => mockSignupViewModel.state).thenReturn(SignupState.initial());
 
//     // Register a fallback value for events and routes
//     registerFallbackValue(FakeLoginEvent());
//     registerFallbackValue(FakeRoute());
 
//     // Setup the service locator to return the mock SignupViewModel
//     // This is crucial because the LoginPage tries to access it for navigation
//     // to the SignupPage.
//     serviceLocator.registerFactory<SignupViewModel>(() => mockSignupViewModel);
//   });
 
//   // This runs after each test to clean up the service locator
//   tearDown(() {
//     serviceLocator.reset();
//   });
 
//   // Helper function to build the widget for testing
//   Future<void> pumpWidget(WidgetTester tester) async {
//     await tester.pumpWidget(
//       BlocProvider<LoginViewModel>.value(
//         value: mockLoginViewModel,
//         child: MaterialApp(
//           home: LoginPage(),
//           // The navigator observer is needed to test navigation
//           navigatorObservers: [mockNavigatorObserver],
//         ),
//       ),
//     );
//   }
 
//   group('LoginPage Widget Tests', () {
//     testWidgets('renders all initial UI elements correctly', (tester) async {
//       // Act
//       await pumpWidget(tester);
//       await tester.pumpAndSettle(); // Allow animations to finish
 
//       // Assert
//       expect(find.text('F2KSTORE'), findsOneWidget);
//       expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
//       expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
//       expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
//       expect(find.text("Don't have an account? "), findsOneWidget);
//       expect(find.text('Sign Up'), findsOneWidget);
//     });
 
//     testWidgets('shows validation errors for empty fields', (tester) async {
//       // Act
//       await pumpWidget(tester);
//       await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//       await tester.pump(); // Rebuild the widget with validation messages
 
//       // Assert
//       expect(find.text('Email is required'), findsOneWidget);
//       expect(find.text('Password is required'), findsOneWidget);
//     });
 
//     testWidgets('shows validation error for invalid email', (tester) async {
//       // Act
//       await pumpWidget(tester);
//       await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'invalid-email');
//       await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//       await tester.pump();
 
//       // Assert
//       expect(find.text('Enter a valid email'), findsOneWidget);
//     });
 
//     testWidgets('shows validation error for short password', (tester) async {
//       // Act
//       await pumpWidget(tester);
//       await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '123');
//       await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//       await tester.pump();
 
//       // Assert
//       expect(find.text('Password must be at least 6 characters'), findsOneWidget);
//     });
 
//     testWidgets('adds LoginSubmitted event when login button is pressed with valid data', (tester) async {
//       // Arrange
//       const email = 'test@example.com';
//       const password = 'password123';
 
//       // Act
//       await pumpWidget(tester);
//       await tester.enterText(find.widgetWithText(TextFormField, 'Email'), email);
//       await tester.enterText(find.widgetWithText(TextFormField, 'Password'), password);
//       await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//       await tester.pump();
 
//       // Assert
//       // Verify that the LoginSubmitted event was added with the correct data.
//       // We use `captureAny` to get the event and inspect its properties.
//       final captured = verify(() => mockLoginViewModel.add(captureAny())).captured;
//       final event = captured.last as LoginSubmitted;
     
//       expect(event.email, email);
//       expect(event.password, password);
//     });
 
//     testWidgets('navigates to SignupPage when "Sign Up" is tapped', (tester) async {
//       // Act
//       await pumpWidget(tester);
//       await tester.tap(find.text('Sign Up'));
//       await tester.pumpAndSettle(); // Wait for navigation animation to complete
 
//       // Assert
//       // Verify that a new route was pushed onto the navigator
//       verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
//       // Verify that the new page is the SignupPage
//       expect(find.byType(SignupPage), findsOneWidget);
//     });
//   });
// }