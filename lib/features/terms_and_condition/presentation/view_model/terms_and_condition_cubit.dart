import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'terms_and_condition_state.dart';

class TermsAndConditionCubit extends Cubit<TermsAndConditionState> {
  TermsAndConditionCubit() : super(TermsAndConditionInitial());
}