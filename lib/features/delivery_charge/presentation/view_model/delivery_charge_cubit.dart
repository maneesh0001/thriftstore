import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_charge_state.dart';

class DeliveryChargeCubit extends Cubit<DeliveryChargeState> {
  DeliveryChargeCubit() : super(DeliveryChargeInitial());
}