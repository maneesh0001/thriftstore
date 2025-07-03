// import 'package:hive_flutter/adapters.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:thrift_store/app/constant/hive/hive_table_constant.dart';
// import 'package:thrift_store/features/auth/data/model/auth_hive_model.dart';

 
// class HiveService {
//   Future<void> init() async {
//     var dir = await getApplicationDocumentsDirectory();
 
//     var path = '${dir.path}thrillquest.db';
 
//     Hive.init(path);
 
//     Hive.registerAdapter(AuthHiveModelAdapter());
//   }
 
//   Future<void> createAccount(AuthHiveModel auth) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     await box.put(auth.userId, auth);
//   }
 
//   Future<AuthHiveModel?> login(String email, String password) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
//     var user = box.values.firstWhere(
//       (element) => element.email == email && element.password == password,
//       orElse: () => throw Exception('Invalid email or password!'),
//     );
 
//     box.close();
//     return user;
//   }
// }
 
 