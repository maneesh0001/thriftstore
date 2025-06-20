
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/app/theme/my_theme.dart';
import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
import 'package:thrift_store/features/auth/presentation/view/signup_page.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:thrift_store/features/dashboard/presentation/view/dashboard_screen.dart';
import 'package:thrift_store/view/splashview/splashscreen.dart';

class App extends StatelessWidget {
  const App({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login':
            (context) => BlocProvider.value(
              value: serviceLocator<LoginViewModel>(),
              child: LoginPage(),
            ),
        '/signup':
            (context) => BlocProvider.value(
              value: serviceLocator<SignupViewModel>(),
              child: SignupPage(),
            ),
        '/homeScreen': (context) => DashboardScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
    );
  }
}
 