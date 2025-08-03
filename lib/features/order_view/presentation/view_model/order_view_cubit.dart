import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_view_state.dart';

class OrderViewCubit extends Cubit<OrderViewState> {
  OrderViewCubit() : super(OrderViewInitial());
}