import 'package:flutter/material.dart'; // Assuming this import is correct
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/core/common/snackbar.dart';
import 'package:thrift_store/features/home/presentation/view_model/home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  /// Update the selected tab index
  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  // Assuming you had a logout method here, keeping it as is
  void logout(BuildContext context) {
    // Implement your logout logic here
    // Example: Clear user session, navigate to login page
    showMySnackBar(
      context: context,
      message: 'Logging out...',
      color: Colors.red,
    );
    // Navigator.of(context).pushReplacementNamed('/login'); // Example navigation
  }
}
