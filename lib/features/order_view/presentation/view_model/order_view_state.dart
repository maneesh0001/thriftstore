part of 'order_view_cubit.dart';

sealed class OrderViewState extends Equatable {
  const OrderViewState();

  @override
  List<Object> get props => [];
}

final class OrderViewInitial extends OrderViewState {}