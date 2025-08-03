// Adjust import for thrift_store project if needed
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/features/auth/presentation/view/my_information_view.dart';
import 'package:thrift_store/features/auth/presentation/view_model/update_user/my_information_bloc.dart';
import 'package:thrift_store/features/help/presentation/view/help_view.dart';
import 'package:thrift_store/features/help/presentation/view_model/help_cubit.dart';
import 'package:thrift_store/features/order_view/presentation/view/view_order.dart';
import 'package:thrift_store/features/order_view/presentation/view_model/order_view_cubit.dart';
import 'package:thrift_store/features/support/presentation/view/support_view.dart';
import 'package:thrift_store/features/support/presentation/view_model/support_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final OrderViewCubit _orderViewCubit;
  final MyInformationBloc _myInformationBloc;
  final HelpCubit _help;
  final SupportCubit _support;

  ProfileCubit(
      {required OrderViewCubit orderViewCubit,
      required MyInformationBloc myInformationBloc,
      required HelpCubit help,
      required SupportCubit support})
      : _orderViewCubit = orderViewCubit,
        _myInformationBloc = myInformationBloc,
        _help = help,
        _support = support,
        super(ProfileInitial());

  Future<void> navigateToOrder(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _orderViewCubit,
            child: const ViewOrder(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToMyInformation(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _myInformationBloc,
            child: const MyInformationScreen(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToHelp(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _help,
            child: const HelpView(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToSupport(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _support,
            child: const SupportView(),
          ),
        ),
      );
    }
  }
}