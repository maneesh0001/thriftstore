import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thrift_store/app/constant/hive/hive_table_constant.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';
import 'package:uuid/uuid.dart';

part 'product_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel extends Equatable {
  @HiveField(0)
  final String? productId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final int stock;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String condition;

  @HiveField(6)
  final String imageUrl;

  ProductHiveModel({
    String? productId,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.condition,
    required this.imageUrl,
  }) : productId = productId ?? const Uuid().v4();

  const ProductHiveModel.initial()
      : productId = null,
        name = '',
        price = 0,
        stock = 0,
        category = '',
        condition = '',
        imageUrl = '';

  /// Convert domain entity to Hive model
  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      productId: entity.productId,
      name: entity.name,
      price: entity.price,
      stock: entity.stock,
      category: entity.category,
      condition: entity.condition,
      imageUrl: entity.imageUrl,
    );
  }

  /// Convert Hive model to domain entity
  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      name: name,
      price: price,
      stock: stock,
      category: category,
      condition: condition,
      imageUrl: imageUrl,
    );
  }

  /// Convert list of entities to list of Hive models
  static List<ProductHiveModel> fromEntityList(List<ProductEntity> entityList) {
    return entityList.map((e) => ProductHiveModel.fromEntity(e)).toList();
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        price,
        stock,
        category,
        condition,
        imageUrl,
      ];
}
