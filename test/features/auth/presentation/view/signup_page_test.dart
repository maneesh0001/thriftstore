import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:thrift_store/features/auth/presentation/view/signup_page.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';

// Mocks
class MockSignupViewModel extends MockBloc<SignupEvent, SignupState>
    implements SignupViewModel {}

// A dummy BuildContext is needed for events that require it.
class MockBuildContext extends Mock implements BuildContext {}

// Fakes
// We only need to fake the state, not the sealed event.
class FakeSignupState extends Fake implements SignupState {}

void main() {
  setUpAll(() {
    // FIXED: Register a concrete event instance as a fallback.
    // We provide dummy data that matches the event's constructor.
    registerFallbackValue(RegisterAccountEvent(
      context: MockBuildContext(),
      email: '',
      fullName: '',
      password: '',
    ));
    registerFallbackValue(FakeSignupState());
  });

  group('SignupPage', () {
    late MockSignupViewModel mockSignupViewModel;

    setUp(() {
      mockSignupViewModel = MockSignupViewModel();
      // Stub the initial state
      when(() => mockSignupViewModel.state).thenReturn(SignupState.initial());
    });

    // Helper to build the widget tree
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: BlocProvider<SignupViewModel>.value(
          value: mockSignupViewModel,
          child: SignupPage(),
        ),
      );
    }

    testWidgets('renders all required form fields and a signup button',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.widgetWithText(TextFormField, 'Full Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Confirm Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
      expect(find.text('Already have an account? '), findsOneWidget);
    });

    testWidgets('shows validation errors when signup is tapped with empty fields',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump(); // Re-render with validation messages

      // Assert
      expect(find.text('Full Name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'invalid-email');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump();

      // Assert
      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('shows validation error for password mismatch', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'password456');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump();

      // Assert
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('adds RegisterAccountEvent when form is valid and button is tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.widgetWithText(TextFormField, 'Full Name'), 'Test User');
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'password123');
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump();

      // Assert
      final captured = verify(() => mockSignupViewModel.add(captureAny(that: isA<RegisterAccountEvent>())))
          .captured
          .last as RegisterAccountEvent;

      expect(captured.fullName, 'Test User');
      expect(captured.email, 'test@example.com');
      expect(captured.password, 'password123');
    });

  });
}
