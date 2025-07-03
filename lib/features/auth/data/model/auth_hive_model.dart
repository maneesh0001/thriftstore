// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:uuid/uuid.dart';

// // Make sure to import your UserEntity and Hive constants
// import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
// import 'package:thrift_store/app/constant/hive/hive_table_constant.dart';

// part 'auth_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.userTableId)
// class AuthHiveModel extends Equatable {
//   // Field for the user's unique ID, with Hive index 0.
//   // Using 'userId' for clarity in the data layer.
//   @HiveField(0)
//   final String? userId;

//   // Field for email, with Hive index 1.
//   @HiveField(1)
//   final String email;

//   // Field for name, with Hive index 2.
//   @HiveField(2)
//   final String name;

//   // Field for password, with Hive index 3.
//   @HiveField(3)
//   final String password;

//   // Field for phone number, with Hive index 4.
//   @HiveField(4)
//   final String phoneNumber;

//   // Constructor for the Hive model.
//   // If a userId isn't provided, it generates a new v4 UUID.
//   AuthHiveModel({
//     String? userId,
//     required this.email,
//     required this.name,
//     required this.password,
//     required this.phoneNumber,
//   }) : userId = userId ?? const Uuid().v4();

//   // A factory constructor to create an AuthHiveModel FROM a UserEntity.
//   // This is used when you want to save a user to the database.
//   factory AuthHiveModel.fromEntity(UserEntity entity) {
//     return AuthHiveModel(
//       userId: entity.id,
//       email: entity.email,
//       name: entity.name,
//       password: entity.password,
//       phoneNumber: entity.phoneNumber,
//     );
//   }

//   // A method to convert this AuthHiveModel back TO a UserEntity.
//   // This is used when you read a user from the database.
//   UserEntity toEntity() {
//     return UserEntity(
//       id: userId,
//       email: email,
//       name: name,
//       password: password,
//       phoneNumber: phoneNumber,
//     );
//   }

//   @override
//   List<Object?> get props => [userId, email, name, password, phoneNumber];
// }
