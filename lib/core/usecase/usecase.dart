// lib/core/usecase/usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thrift_store/core/error/failure.dart'; // Ensure this path is correct for your Failure class

/// Abstract base class for use cases that take parameters and return a result.
/// [Type] is the type of the return value (e.g., void, String, User).
/// [Params] is the type of the input parameters (e.g., UpdateUserParams, NoParams).
abstract class UsecaseWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Abstract base class for use cases that take no parameters and return a result.
abstract class UsecaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// A specific class to indicate no parameters are needed for a use case.
class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}