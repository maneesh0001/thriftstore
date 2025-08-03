import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/cart/domain/entity/cart_item_entity.dart';
import 'package:thrift_store/features/cart/domain/use_case/add_to_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/remove_from_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_state.dart';

// ---- Mock Classes ----
class MockUserSharedPrefs extends Mock implements UserSharedPrefs {}
class MockAddToCartUseCase extends Mock implements AddToCartUseCase {}
class MockRemoveFromCartUseCase extends Mock implements RemoveFromCartUseCase {}
class MockClearCartUseCase extends Mock implements ClearCartUseCase {}
class MockGetCartUseCase extends Mock implements GetCartUseCase {}

class FakeCartItemEntity extends Fake implements CartItemEntity {}

void main() {
  late MockUserSharedPrefs mockUserSharedPrefs;
  late MockAddToCartUseCase mockAddToCartUseCase;
  late MockRemoveFromCartUseCase mockRemoveFromCartUseCase;
  late MockClearCartUseCase mockClearCartUseCase;
  late MockGetCartUseCase mockGetCartUseCase;

  final tUser = UserData(
    token: 'token123',
    userId: 'user123',
    email: 'test@example.com',
    name: 'Test User',
    role: 'user',
  );

  final tCartItem = CartItemEntity(
    productId: 'prod1',
    productName: 'Product 1',
    productImage: '',
    productDescription: '',
    quantity: 2,
    price: 100.0,
  );

  setUp(() {
    mockUserSharedPrefs = MockUserSharedPrefs();
    mockAddToCartUseCase = MockAddToCartUseCase();
    mockRemoveFromCartUseCase = MockRemoveFromCartUseCase();
    mockClearCartUseCase = MockClearCartUseCase();
    mockGetCartUseCase = MockGetCartUseCase();

    registerFallbackValue(FakeCartItemEntity());

    when(() => mockUserSharedPrefs.getUserData())
        .thenAnswer((_) async => Right(tUser));
  });

  CartBloc createBloc({bool load = false}) {
    return CartBloc(
      userSharedPrefs: mockUserSharedPrefs,
      addToCartUseCase: mockAddToCartUseCase,
      removeFromCartUseCase: mockRemoveFromCartUseCase,
      clearCartUseCase: mockClearCartUseCase,
      getCartUseCase: mockGetCartUseCase,
    );
  }

  group('CartBloc Tests', () {
    blocTest<CartBloc, CartState>(
      'emits loaded cart on LoadCartEvent success',
      build: () {
        when(() => mockGetCartUseCase(any()))
            .thenAnswer((_) async => [tCartItem]);
        return createBloc();
      },
      act: (bloc) => bloc.add(const LoadCartEvent()),
      expect: () => [
        CartState.initial().copyWith(isLoading: true, error: null),
        CartState.initial().copyWith(
          items: [tCartItem],
          isLoading: false,
          email: tUser.email,
          name: tUser.name,
          role: tUser.role,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits error when LoadCartEvent user data fails',
      build: () {
        when(() => mockUserSharedPrefs.getUserData())
            .thenAnswer((_) async => Left(ApiFailure(message: 'No user')));
        return createBloc();
      },
      act: (bloc) => bloc.add(const LoadCartEvent()),
      expect: () => [
        CartState.initial().copyWith(isLoading: true, error: null),
        CartState.initial().copyWith(isLoading: false, error: 'No user'),
        CartState.initial().copyWith(isLoading: true, error: 'No user'),
        CartState.initial().copyWith(isLoading: false, error: 'No user'),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits error when LoadCartEvent throws exception in getCart',
      build: () {
        when(() => mockGetCartUseCase(any()))
            .thenThrow(Exception('Cart error'));
        return createBloc();
      },
      act: (bloc) => bloc.add(const LoadCartEvent()),
      expect: () => [
        CartState.initial().copyWith(isLoading: true, error: null),
        CartState.initial().copyWith(isLoading: false, error: 'Exception: Cart error'),
        CartState.initial().copyWith(isLoading: true, error: 'Exception: Cart error'),
        CartState.initial().copyWith(isLoading: false, error: 'Exception: Cart error'),
      ],
    );

    blocTest<CartBloc, CartState>(
      'AddProductToCartEvent calls addToCartUseCase and reloads cart',
      build: () {
        when(() => mockAddToCartUseCase(any())).thenAnswer((_) async {});
        when(() => mockGetCartUseCase(any()))
            .thenAnswer((_) async => [tCartItem]);
        return createBloc();
      },
      act: (bloc) => bloc.add(
        const AddProductToCartEvent(
          productId: 'prod1',
          productName: 'Product 1',
          productPrice: 100.0,
          productQuantity: 2,
        ),
      ),
      verify: (_) {
        verify(() => mockAddToCartUseCase(any())).called(1);
        verify(() => mockGetCartUseCase(any())).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<CartBloc, CartState>(
      'RemoveProductFromCartEvent calls removeFromCartUseCase and reloads cart',
      build: () {
        when(() => mockRemoveFromCartUseCase(any())).thenAnswer((_) async {});
        when(() => mockGetCartUseCase(any())).thenAnswer((_) async => []);
        return createBloc();
      },
      act: (bloc) => bloc.add(const RemoveProductFromCartEvent(productId: 'prod1')),
      verify: (_) {
        verify(() => mockRemoveFromCartUseCase(any())).called(1);
        verify(() => mockGetCartUseCase(any())).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<CartBloc, CartState>(
      'ClearCartEvent success clears items',
      build: () {
        when(() => mockClearCartUseCase()).thenAnswer((_) async {});
        when(() => mockGetCartUseCase(any())).thenAnswer((_) async => []);
        return createBloc();
      },
      act: (bloc) => bloc.add(ClearCartEvent()),
      expect: () => [
        CartState.initial().copyWith(isLoading: true, error: null),
        CartState.initial().copyWith(isLoading: false, items: [], email: tUser.email, name: tUser.name, role: tUser.role),
      ],
    );

    blocTest<CartBloc, CartState>(
      'ClearCartEvent failure emits error',
      build: () {
        when(() => mockClearCartUseCase()).thenThrow(Exception('clear fail'));
        when(() => mockGetCartUseCase(any())).thenAnswer((_) async => []);
        return createBloc();
      },
      act: (bloc) => bloc.add(ClearCartEvent()),
      expect: () => [
        CartState.initial().copyWith(isLoading: true, error: null),
        CartState.initial().copyWith(isLoading: false, error: 'Exception: clear fail', email: null, name: null, role: null),
        CartState.initial().copyWith(isLoading: false, error: 'Exception: clear fail', email: tUser.email, name: tUser.name, role: tUser.role),
      ],
    );

    blocTest<CartBloc, CartState>(
      'IncrementItemQuantityEvent calls addToCartUseCase and reloads cart',
      build: () {
        when(() => mockAddToCartUseCase(any())).thenAnswer((_) async {});
        when(() => mockGetCartUseCase(any())).thenAnswer((_) async => [tCartItem]);
        return createBloc();
      },
      act: (bloc) => bloc.add(const IncrementItemQuantityEvent('prod1')),
      verify: (_) {
        verify(() => mockAddToCartUseCase(any())).called(1);
        verify(() => mockGetCartUseCase(any())).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<CartBloc, CartState>(
      'DecrementItemQuantityEvent calls removeFromCartUseCase and reloads cart',
      build: () {
        when(() => mockRemoveFromCartUseCase(any())).thenAnswer((_) async {});
        when(() => mockGetCartUseCase(any())).thenAnswer((_) async => [tCartItem]);
        return createBloc();
      },
      act: (bloc) => bloc.add(const DecrementItemQuantityEvent('prod1')),
      verify: (_) {
        verify(() => mockRemoveFromCartUseCase(any())).called(1);
        verify(() => mockGetCartUseCase(any())).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<CartBloc, CartState>(
      'Auto-load triggers LoadCartEvent on creation when loadOnCreate = true',
      build: () {
        when(() => mockGetCartUseCase(any()))
            .thenAnswer((_) async => [tCartItem]);
        return createBloc(load: true);
      },
      expect: () => [
        CartState.initial().copyWith(isLoading: true, error: null),
        CartState.initial().copyWith(
          items: [tCartItem],
          isLoading: false,
          email: tUser.email,
          name: tUser.name,
          role: tUser.role,
        )
      ],
    );
  });
}
