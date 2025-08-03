
 

// import 'package:thrift_store/core/network/hive_service.dart';
// import 'package:thrift_store/features/auth/data/data_source/auth_data_source.dart';
// import 'package:thrift_store/features/auth/data/model/auth_hive_model.dart';
// import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';

// class AuthLocalDataSource implements IAuthDataSource {
//   final HiveService _hiveService;

//   AuthLocalDataSource({required HiveService hiveService})
//       : _hiveService = hiveService;

//   @override
//   Future<void> createAccount(UserEntity user) async {
//     try {
//       final authHiveModel = AuthHiveModel(
//         userId: user.id,
//         name: user.name,
//         email: user.email,
//         password: user.password,
//         role: user.role,
//       );
//       await _hiveService.register(authHiveModel); // ✅ match HiveService method name
//     } catch (error) {
//       throw Exception('Registration Failed: $error');
//     }
//   }

//   @override
//   Future<String> loginToAccount(String email, String password) async {
//     try {
//       // Since HiveService.login checks by username, let's adjust it to check email
//       final allUsers = await _hiveService.getAllAuth();
//       final userData = allUsers.firstWhere(
//         (u) => u.email == email && u.password == password,
//         orElse: () => throw Exception('Invalid email or password'),
//       );

//       if (userData != null) {
//         return 'Login successful!';
//       } else {
//         throw Exception('Invalid email or password');
//       }
//     } catch (error) {
//       throw Exception('Login failed! $error');
//     }
//   }
// }
