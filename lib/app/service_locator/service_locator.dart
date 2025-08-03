import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thrift_store/app/shared_prefs/token_shared_prefs.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart';
import 'package:thrift_store/core/network/api_service.dart';
import 'package:thrift_store/core/network/hive_service.dart';

// Auth
import 'package:thrift_store/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:thrift_store/features/auth/data/repository/auth_remote_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';
import 'package:thrift_store/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:thrift_store/features/auth/presentation/view_model/update_user/my_information_bloc.dart';
import 'package:thrift_store/features/bookings/data/data_source/booking_remote_datasoucce.dart';
import 'package:thrift_store/features/bookings/data/repository/booking_remote_repository_impl.dart';
import 'package:thrift_store/features/bookings/domain/repository/booking_repository.dart';
import 'package:thrift_store/features/bookings/domain/usecase/create_booking_usecase.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_view_model.dart';

// Cart
import 'package:thrift_store/features/cart/data/data_source/cart_datasource.dart';
import 'package:thrift_store/features/cart/data/repository/cart_remote_repository.dart';
import 'package:thrift_store/features/cart/domain/repository/cart_repository.dart';
import 'package:thrift_store/features/cart/domain/use_case/add_to_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:thrift_store/features/cart/domain/use_case/remove_from_cart_usecase.dart';
import 'package:thrift_store/features/cart/presentation/view_model/cart_bloc.dart';

// Booking (NEW IMPORTS for booking module)

// Product
import 'package:thrift_store/features/product/data/data_source/remote_datasource/product_remote_data_source.dart';
import 'package:thrift_store/features/product/data/repository/product_remote_repository.dart';
import 'package:thrift_store/features/product/domain/repository/product_repository.dart';
import 'package:thrift_store/features/product/domain/use_case/get_all_product_usecase.dart';
import 'package:thrift_store/features/product/presentation/view_model/product_bloc.dart';

// Profile & Settings
import 'package:thrift_store/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:thrift_store/features/order_view/presentation/view_model/order_view_cubit.dart';
import 'package:thrift_store/features/help/presentation/view_model/help_cubit.dart';
import 'package:thrift_store/features/support/presentation/view_model/support_cubit.dart';

import 'package:thrift_store/features/setting/presentation/view_model/setting_cubit.dart';
import 'package:thrift_store/features/feedback/presentation/view_model/feedback_cubit.dart';
import 'package:thrift_store/features/FAQ/presentation/view_model/faq_cubit.dart';
import 'package:thrift_store/features/about_us/presentation/view_model/about_us_cubit.dart';
import 'package:thrift_store/features/privacy_policy/presentation/view_model/privacy_policy_cubit.dart';
import 'package:thrift_store/features/terms_and_condition/presentation/view_model/terms_and_condition_cubit.dart';
import 'package:thrift_store/features/delivery_charge/presentation/view_model/delivery_charge_cubit.dart';

// Others
import 'package:thrift_store/features/home/presentation/view_model/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initSharedPreferences();
  await _initHiveService();
  await _initApiService();

  _initAuthModule();
  _initLoginDependencies();
  _initRegisterDependencies();

  _initCartDependencies();
  _initProductDependencies();
  _initBookingDependencies(); // NEW: Call the booking dependencies initializer
  _initProfileDependencies();
  _initSettingsDependencies();
  _initHomeDependencies();
}

/// ---------------------------- SERVICES ----------------------------

Future<void> _initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initApiService() async {
  // Register ApiService, providing a new Dio instance and the already registered UserSharedPrefs.
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      Dio(), // Provide a new Dio instance for ApiService to configure
      getIt<UserSharedPrefs>(), // Get the already registered UserSharedPrefs
    ),
  );
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<UserSharedPrefs>(
      () => UserSharedPrefs(sharedPreferences));

  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(sharedPreferences));
}

/// ---------------------------- AUTH ----------------------------

void _initAuthModule() {
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(apiService: getIt<ApiService>()),
  );

  getIt.registerFactory<AuthRemoteRepository>(
    () => AuthRemoteRepository(
        authRemoteDataSource: getIt<AuthRemoteDataSource>()),
  );
}

void _initLoginDependencies() {
  getIt.registerFactory<AuthLoginUsecase>(
    () => AuthLoginUsecase(authRepository: getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
        getIt<AuthLoginUsecase>(),
        getIt<UserSharedPrefs>(),
      ));
}

void _initRegisterDependencies() {
  getIt.registerFactory<AuthRegisterUsecase>(
    () => AuthRegisterUsecase(authRepository: getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<SignupViewModel>(
    () => SignupViewModel(getIt<AuthRegisterUsecase>()),
  );
}

/// ---------------------------- CART ----------------------------
void _initCartDependencies() {
  // Data Source
  getIt.registerLazySingleton<CartDatasource>(
    () => CartDatasource(
      userSharedPrefs: getIt<UserSharedPrefs>(),
      apiService: getIt<ApiService>(), // Correctly pass ApiService
    ),
  );

  // Repository Implementation Binding
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(cartDatasource: getIt<CartDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<ClearCartUseCase>(
    () => ClearCartUseCase(getIt<CartRepository>()),
  );

  getIt.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(getIt<CartRepository>()),
  );

  // Bloc
  getIt.registerFactory<CartBloc>(
    () => CartBloc(
        userSharedPrefs: getIt<UserSharedPrefs>(),
        addToCartUseCase: getIt<AddToCartUseCase>(),
        removeFromCartUseCase: getIt<RemoveFromCartUseCase>(),
        clearCartUseCase: getIt<ClearCartUseCase>(),
        getCartUseCase: getIt<GetCartUseCase>()),
  );
}

/// ---------------------------- BOOKING (NEW) ----------------------------
void _initBookingDependencies() {
  // Data Source
  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  // Repository
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(
        remoteDataSource: getIt<BookingRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<CreateBookingUseCase>(
    () => CreateBookingUseCase(repository: getIt<BookingRepository>()),
  );
  // getIt.registerLazySingleton<GetBookingsUseCase>(
  //   () => GetBookingsUseCase(repository: getIt<BookingRepository>()),
  // );

  // Bloc
  getIt.registerFactory<BookingBloc>(
    () => BookingBloc(
      createBookingUseCase: getIt<CreateBookingUseCase>(),
      // getBookingsUseCase: getIt<GetBookingsUseCase>(),
    ),
  );
}



void _initProductDependencies() {
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(
      getIt<ApiService>().dio, // Get the configured Dio from ApiService
      getIt<UserSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRemoteRepository(
        remoteDataSource: getIt<ProductRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetAllProductUsecase>(
    () => GetAllProductUsecase(productRepository: getIt<IProductRepository>()),
  );

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getAllProductUsecase: getIt<GetAllProductUsecase>()),
  );
}



void _initProfileDependencies() {
  getIt.registerLazySingleton<UpdateUserUsecase>(
    () => UpdateUserUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<MyInformationBloc>(
    () => MyInformationBloc(updateUserUsecase: getIt<UpdateUserUsecase>()),
  );

  getIt.registerFactory<OrderViewCubit>(() => OrderViewCubit());
  getIt.registerFactory<HelpCubit>(() => HelpCubit());
  getIt.registerFactory<SupportCubit>(() => SupportCubit());

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      orderViewCubit: getIt<OrderViewCubit>(),
      myInformationBloc: getIt<MyInformationBloc>(),
      help: getIt<HelpCubit>(),
      support: getIt<SupportCubit>(),
    ),
  );
}

/// ---------------------------- SETTINGS ----------------------------

void _initSettingsDependencies() {
  getIt.registerFactory<FeedbackCubit>(() => FeedbackCubit());
  getIt.registerFactory<FaqCubit>(() => FaqCubit());
  getIt.registerFactory<AboutUsCubit>(() => AboutUsCubit());
  getIt.registerFactory<DeliveryChargeCubit>(() => DeliveryChargeCubit());
  getIt.registerFactory<TermsAndConditionCubit>(() => TermsAndConditionCubit());
  getIt.registerFactory<PrivacyPolicyCubit>(() => PrivacyPolicyCubit());

  getIt.registerFactory<SettingCubit>(
    () => SettingCubit(
      getIt<FeedbackCubit>(),
      getIt<FaqCubit>(),
      getIt<AboutUsCubit>(),
      getIt<DeliveryChargeCubit>(),
      getIt<TermsAndConditionCubit>(),
      getIt<PrivacyPolicyCubit>(),
    ),
  );
}

/// ---------------------------- HOME ----------------------------

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
