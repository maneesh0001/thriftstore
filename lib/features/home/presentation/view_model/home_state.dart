import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/features/home/presentation/view/home_view.dart';
import 'package:thrift_store/features/product/presentation/view_model/product_bloc.dart';
import 'package:thrift_store/features/profile/presentation/view/profile_page.dart';
import 'package:thrift_store/features/profile/presentation/view/profile_screen_view.dart';
import 'package:thrift_store/features/profile/presentation/view_model/profile_cubit.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  /// Initial state with predefined views
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        // Dashboard / HomeView
        BlocProvider<ProductBloc>(
          create: (context) => getIt<ProductBloc>(),
          child: const HomeView(),
        ),

        // 🟡 Placeholder instead of CartBloc
        const Scaffold(
          body: Center(
            child: Text(
              'Cart Placeholder View',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),

        // Profile screen with real ProfileCubit
        BlocProvider.value(
          value: getIt<ProfileCubit>(),
          child: const ProfilePage(),
        ),

        // 🟡 Placeholder instead of SettingCubit
        const Scaffold(
          body: Center(
            child: Text(
              'Settings Placeholder View',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
