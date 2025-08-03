import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/domain/use_case/add_to_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/remove_from_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final ClearCartUseCase clearCartUseCase;
  final GetCartUseCase getCartUseCase;
  final UserSharedPrefs userSharedPrefs;

  CartBloc({
    required this.userSharedPrefs,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.clearCartUseCase,
    required this.getCartUseCase,
  }) : super(CartState.initial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddProductToCartEvent>(_onAddProduct);
    on<RemoveProductFromCartEvent>(_onRemoveProduct);
    on<ClearCartEvent>(_onClearCart);
    on<IncrementItemQuantityEvent>(_onIncrementItem);
    on<DecrementItemQuantityEvent>(_onDecrementItem);

    add(const LoadCartEvent()); // Trigger cart load on bloc creation
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final userDataResult = await userSharedPrefs.getUserData();
    await userDataResult.fold(
      (failure) async {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (user) async {
        try {
          final cartItems = await getCartUseCase(user.userId);
          emit(state.copyWith(
            items: cartItems,
            isLoading: false,
            email: user.email,
            name: user.name,
            role: user.role,
          ));
        } catch (e) {
          emit(state.copyWith(isLoading: false, error: e.toString()));
        }
      },
    );
  }

  Future<void> _onAddProduct(
      AddProductToCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final userDataResult = await userSharedPrefs.getUserData();
    await userDataResult.fold(
      (failure) async =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (user) async {
        final item = CartItemEntity(
          productId: event.productId,
          productName: event.productName,
          productImage: '',
          productDescription: '',
          quantity: event.productQuantity,
          price: event.productPrice,
        );

        await addToCartUseCase(item);
        add(const LoadCartEvent());
      },
    );
  }

  Future<void> _onRemoveProduct(
      RemoveProductFromCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final userDataResult = await userSharedPrefs.getUserData();
    await userDataResult.fold(
      (failure) async =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (user) async {
        final item = CartItemEntity(
          productId: event.productId,
          productName: '',
          productImage: '',
          productDescription: '',
          quantity: 1,
          price: 0,
        );

        await removeFromCartUseCase(item);
        add(const LoadCartEvent());
      },
    );
  }

  Future<void> _onClearCart(
      ClearCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await clearCartUseCase();
      emit(state.copyWith(isLoading: false, items: []));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onIncrementItem(
      IncrementItemQuantityEvent event, Emitter<CartState> emit) async {
    // This logic is simplified. You might need a specific `incrementUseCase`.
    // For now, we reuse `addToCartUseCase` assuming the backend can handle it.
    final item = CartItemEntity(
      productId: event.productId,
      productName: '', // Not needed for increment
      price: 0, // Not needed for increment
      quantity: 1, // We are adding 1
      //... other fields can be empty
    );
    await addToCartUseCase(item);
    add(const LoadCartEvent()); // Reload the cart to show the new quantity
  }

  // This handler is now ONLY for decrementing by one
  Future<void> _onDecrementItem(
      DecrementItemQuantityEvent event, Emitter<CartState> emit) async {
    // You'll need a specific `removeFromCartUseCase` that can decrement by one
    // Let's assume your existing one works for this.
    final item = CartItemEntity(
      productId: event.productId, quantity: 1,
      //... other fields can be empty
    );
    await removeFromCartUseCase(
        item); // This should tell the backend to remove one
    add(const LoadCartEvent()); // Reload the cart
  }
}
