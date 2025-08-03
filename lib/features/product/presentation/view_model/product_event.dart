

import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class LoadProducts extends ProductEvent {}
