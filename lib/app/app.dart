// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thrift_store/app/service_locator/service_locator.dart';
// import 'package:thrift_store/app/theme/my_theme.dart';
// import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
// import 'package:thrift_store/features/auth/presentation/view/signup_page.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
// import 'package:thrift_store/features/dashboard/presentation/view/dashboard_view.dart';
// import 'package:thrift_store/view/splashview/splashscreen.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/': (context) => SplashScreen(),
//         '/login':
//             (context) => BlocProvider.value(
//               value: serviceLocator<LoginViewModel>(),
//               child: LoginPage(),
//             ),
//         '/signup':
//             (context) => BlocProvider.value(
//               value: serviceLocator<SignupViewModel>(),
//               child: SignupPage(),
//             ),
//         '/dashboard': (context) => DashboardView(),
//       },
//       debugShowCheckedModeBanner: false,
//       theme: getTheme(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/app/theme/my_theme.dart';
import 'package:thrift_store/features/auth/presentation/view/login_page.dart';
import 'package:thrift_store/features/auth/presentation/view/signup_page.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_view_model.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:thrift_store/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:thrift_store/features/dashboard/presentation/view_model/dashboard_bloc.dart';
import 'package:thrift_store/features/home/presentation/view/home_view.dart';
import 'package:thrift_store/features/home/presentation/view_model/home_cubit.dart';
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';
import 'package:thrift_store/features/product/presentation/view_model/product_bloc.dart';
import 'package:thrift_store/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:thrift_store/features/setting/presentation/view_model/setting_cubit.dart';
import 'package:thrift_store/view/splashview/splashscreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginViewModel>(
          create: (_) => getIt<LoginViewModel>(),
        ),
        BlocProvider<SignupViewModel>(
          create: (_) => getIt<SignupViewModel>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => DashboardBloc(
              getAllProductUsecase: getIt<GetAllProductUsecase>()),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<CartBloc>(
          create: (_) =>
              getIt<CartBloc>(), // <-- Ensure CartBloc is registered in getIt
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => getIt<
              ProfileCubit>(), // <-- Ensure ProfileCubit is registered in getIt
        ),
        BlocProvider<SettingCubit>(
          create: (_) => getIt<
              SettingCubit>(), // <-- Ensure ProfileCubit is registered in getIt
        ),
        BlocProvider<ProductBloc>(
          // <-- Add this line
          create: (_) => getIt<ProductBloc>(),
        ),

        BlocProvider<BookingBloc>(
          create: (_) => getIt<BookingBloc>(),
        ),
        // Add any other cubits/blocs your pages use globally
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/dashboard': (context) => const DashboardView(),
          '/home': (context) => const HomeView(),
          // Add your cart page if it uses named route like '/cart'
        },
        debugShowCheckedModeBanner: false,
        theme: getTheme(),
      ),
    );
  }
}
