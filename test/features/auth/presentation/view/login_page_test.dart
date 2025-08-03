import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

// Mocks and fakes
class MockLoginViewModel extends MockBloc<LoginEvent, LoginState>
    implements LoginViewModel {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLoginEvent());
    registerFallbackValue(FakeLoginState());
  });

  late MockLoginViewModel mockLoginViewModel;

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();
  });

  Widget createWidgetUnderTest({Map<String, WidgetBuilder>? routes}) {
    return MaterialApp(
      routes: routes ?? const {},
      home: BlocProvider<LoginViewModel>.value(
        value: mockLoginViewModel,
        child: LoginPage(),
      ),
    );
  }

  testWidgets('renders email and password fields and login button',
      (WidgetTester tester) async {
    when(() => mockLoginViewModel.state)
        .thenReturn(const LoginState(isLoading: false, isSuccess: false));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextFormField), findsNWidgets(2)); // email + password
    expect(find.text("Login"), findsOneWidget);
    expect(find.text("Don't have an account? "), findsOneWidget);
  });

  testWidgets('adds LoginSubmitted event when login button is pressed with valid input',
      (WidgetTester tester) async {
    when(() => mockLoginViewModel.state)
        .thenReturn(const LoginState(isLoading: false, isSuccess: false));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');

    await tester.tap(find.text("Login"));
    await tester.pump();

    verify(() => mockLoginViewModel.add(
      any(that: isA<LoginSubmitted>()),
    )).called(1);
  });

  testWidgets('navigates to /dashboard when login is successful',
    (WidgetTester tester) async {
  when(() => mockLoginViewModel.state)
      .thenReturn(const LoginState(isLoading: false, isSuccess: false));

  // Setup the whenListen BEFORE pumping widget
  whenListen(
    mockLoginViewModel,
    Stream.fromIterable([
      const LoginState(isLoading: false, isSuccess: false),
      const LoginState(isLoading: false, isSuccess: true),
    ]),
    initialState: const LoginState(isLoading: false, isSuccess: false),
  );

  await tester.pumpWidget(createWidgetUnderTest(routes: {
    '/dashboard': (context) => const Scaffold(body: Text('Dashboard')),
  }));

  // pump to process the stream events and rebuild widget tree
  await tester.pump(); 

  // pump again to allow Navigator animation
  await tester.pump(const Duration(seconds: 1)); 

  expect(find.text('Dashboard'), findsOneWidget);
});
}
