
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/features/FAQ/presentation/view/faq_screen.dart';
import 'package:thrift_store/features/FAQ/presentation/view_model/faq_cubit.dart';
import 'package:thrift_store/features/about_us/presentation/view/about_us_screen.dart';
import 'package:thrift_store/features/about_us/presentation/view_model/about_us_cubit.dart';
import 'package:thrift_store/features/delivery_charge/presentation/view/delivery_charge_screen.dart';
import 'package:thrift_store/features/delivery_charge/presentation/view_model/delivery_charge_cubit.dart';
import 'package:thrift_store/features/feedback/presentation/view/feedback_screen.dart';
import 'package:thrift_store/features/feedback/presentation/view_model/feedback_cubit.dart';
import 'package:thrift_store/features/privacy_policy/presentation/view/privacy_policy_screen.dart';
import 'package:thrift_store/features/privacy_policy/presentation/view_model/privacy_policy_cubit.dart';
import 'package:thrift_store/features/terms_and_condition/presentation/view/terms_and_condition_view.dart';
import 'package:thrift_store/features/terms_and_condition/presentation/view_model/terms_and_condition_cubit.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<void> {
  SettingCubit(
    this._feedbackCubit,
    this._faqCubit,
    this._aboutUsCubit,
    this._deliveryChargeCubit,
    this._termCubit,
    this._privacyPolicyCubit,
  ) : super(null);

  final FeedbackCubit _feedbackCubit;
  final FaqCubit _faqCubit;
  final AboutUsCubit _aboutUsCubit;
  final DeliveryChargeCubit _deliveryChargeCubit;
  final TermsAndConditionCubit _termCubit;
  final PrivacyPolicyCubit _privacyPolicyCubit;

  Future<void> navigateToTermsPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _termCubit,
            child: const TermsAndConditionView(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToPrivacyPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _privacyPolicyCubit,
            child: const PrivacyPolicyView(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToDeliveryPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _deliveryChargeCubit,
            child: const DeliveryChargeView(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToAboutPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _aboutUsCubit,
            child: const AboutUsScreen(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToFaqPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _faqCubit,
            child: const FaqScreen(),
          ),
        ),
      );
    }
  }

  Future<void> navigateToFeedbackPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _feedbackCubit,
            child: const FeedbackScreen(),
          ),
        ),
      );
    }
  }
}