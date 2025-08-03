// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:thrift_store/core/error/failure.dart';

// class UserSharedPrefs {
//   final SharedPreferences _sharedPreferences;
//   UserSharedPrefs(this._sharedPreferences);

//   Future<Either<Failure, List<String>>> getUserId() async {
//     try {
//       final userId = _sharedPreferences.getString('userId') ?? '';
//       final name = _sharedPreferences.getString('name') ?? '';
//       final email = _sharedPreferences.getString('email') ?? '';
//       return Right([email, name, userId]);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }
// }


import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_store/core/error/failure.dart';

class UserData {
  final String token;
  final String userId;   // Added userId here
  final String email;
  final String name;
  final String role;

  UserData({
    required this.token,
    required this.userId,  // constructor param
    required this.email,
    required this.name,
    required this.role,
  });
}

class UserSharedPrefs {
  static const _keyToken = 'token';
  static const _keyUserId = 'userId';  // key for userId
  static const _keyEmail = 'email';
  static const _keyName = 'name';
  static const _keyRole = 'role';

  final SharedPreferences _prefs;

  UserSharedPrefs(this._prefs);

  Future<void> saveUser({
    required String token,
    required String userId,   // added here
    required String email,
    required String name,
    required String role,
  }) async {
    await _prefs.setString(_keyToken, token);
    await _prefs.setString(_keyUserId, userId);  // save userId
    await _prefs.setString(_keyEmail, email);
    await _prefs.setString(_keyName, name);
    await _prefs.setString(_keyRole, role);
  }

  Future<Either<Failure, UserData>> getUserData() async {
    try {
      final token = _prefs.getString(_keyToken);
      final userId = _prefs.getString(_keyUserId);  // read userId
      final email = _prefs.getString(_keyEmail);
      final name = _prefs.getString(_keyName);
      final role = _prefs.getString(_keyRole);

        debugPrint('UserSharedPrefs: Retrieved name: $name'); // Add this!
      debugPrint('UserSharedPrefs: Retrieved email: $email'); // Add this!


      if (token == null || userId == null || email == null || name == null || role == null) {
        return Left(SharedPrefsFailure(message: 'No user data found'));
      }

      return Right(
        UserData(
          token: token,
          userId: userId,  // pass userId
          email: email,
          name: name,
          role: role,
        ),
      );
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}

class SharedPrefsFailure extends Failure {
  SharedPrefsFailure({required String message}) : super(message: message);
}
