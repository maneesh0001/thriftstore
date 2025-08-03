import 'package:hive_flutter/hive_flutter.dart';
import 'package:thrift_store/app/constant/hive/hive_table_constant.dart';
import 'package:thrift_store/features/auth/data/model/auth_hive_model.dart';
import 'package:thrift_store/features/product/data/model/product_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ProductHiveModelAdapter());
 
  }

  // --- Auth-related methods ---

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    return box.values.toList();
  }

  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    try {
      return box.values.firstWhere(
        (element) => element.name == username && element.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
  }

  // --- Product-related methods ---

  Future<Box<ProductHiveModel>> _openProductBox() async {
    return await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
  }

  Future<void> addProduct(ProductHiveModel product) async {
    final box = await _openProductBox();
    await box.put(product.productId, product);
  }

  Future<List<ProductHiveModel>> getAllProducts() async {
    final box = await _openProductBox();
    return box.values.toList();
  }

  Future<ProductHiveModel?> getProductById(String productId) async {
    final box = await _openProductBox();
    return box.get(productId);
  }

  Future<void> updateProduct(ProductHiveModel product) async {
    final box = await _openProductBox();
    await box.put(product.productId, product);
  }

  Future<void> deleteProduct(String productId) async {
    final box = await _openProductBox();
    await box.delete(productId);
  }

  // --- General ---

  Future<void> close() async {
    await Hive.close();
  }
}
