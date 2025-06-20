
 
import 'package:get_it/get_it.dart';
import 'package:thrift_store/core/network/hive_service.dart';
import 'package:thrift_store/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:thrift_store/features/auth/data/repository/auth_local_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';
import 'package:thrift_store/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:thrift_store/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';

final serviceLocator = GetIt.instance;
 
Future<void> initDependencies() async {
  _initAuthModule();
  _initHiveService();
}
 
Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}
 
Future<void> _initAuthModule() async {
  serviceLocator.registerFactory(
    () => AuthLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );
 
  serviceLocator.registerFactory(
    () => AuthLocalRepository(
      authLocalDataSource: serviceLocator<AuthLocalDataSource>(),
    ),
  );
 
  serviceLocator.registerFactory(
    () => AuthRegisterUsecase(authRepository: serviceLocator<AuthLocalRepository>())
  );
 
  serviceLocator.registerFactory(
    () => AuthLoginUsecase(authRepository: serviceLocator<AuthLocalRepository>())
  );
 
  serviceLocator.registerFactory<SignupViewModel>(() => SignupViewModel(
    serviceLocator<AuthRegisterUsecase>()
  ));
 
  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel(
    serviceLocator<AuthLoginUsecase>()
  ));
}