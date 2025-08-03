import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:thrift_store/features/product/domain/entiry/product_entity.dart';


part 'product_api_model.g.dart'; // This line is crucial for code generation

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to the model.

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id') // Maps '_id' from JSON to productId in your model
  final String? productId;
  final String name;
  final int price;
  final int stock;
  final String category;
  final String condition;
  final String imageUrl;

  const ProductApiModel({
    this.productId,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
  
    required this.condition,
    required this.imageUrl,
  });

  const ProductApiModel.empty()
      : productId = '', // Assuming 'empty.id' is not a requirement, '' is common for empty string
        name = '',
        price = 0,
        stock = 0,
        category = '',
       
        condition = '',
        imageUrl = '';

  // Use the generated fromJson and toJson methods
  factory ProductApiModel.fromJson(Map<String, dynamic> json) => _$ProductApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // Convert API Object to Entity
  ProductEntity toEntity() => ProductEntity(
        productId: productId,
        name: name,
        price: price,
        stock: stock,
        category: category,
        condition: condition,
        imageUrl: imageUrl,
      );

  // Convert Entity to API Object
  static ProductApiModel fromEntity(ProductEntity entity) => ProductApiModel(
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        stock: entity.stock,
        category: entity.category,
        condition: entity.condition,
        imageUrl: entity.imageUrl, 
      );

  // Convert API List to Entity List
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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