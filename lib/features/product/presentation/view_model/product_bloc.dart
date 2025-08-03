import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';
import 'package:thrift_store/features/product/presentation/view_model/product_event.dart';


part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductUsecase _getAllProductUsecase;

  ProductBloc({
    required GetAllProductUsecase getAllProductUsecase,
  })  : _getAllProductUsecase = getAllProductUsecase,
        super(ProductState.initial()) {
    on<LoadProducts>(_onLoadProducts);

    // Optionally, trigger loading immediately
    add(LoadProducts());
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllProductUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (products) =>
          emit(state.copyWith(isLoading: false, products: products, error: null)),
    );
  }
}


