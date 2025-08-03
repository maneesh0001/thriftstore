// lib/features/booking/data/repository/booking_remote_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/bookings/data/data_source/booking_remote_datasoucce.dart';
import 'package:thrift_store/features/bookings/domain/entity/booking_entity.dart';
import 'package:thrift_store/features/bookings/domain/repository/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BookingEntity>> createBooking() async {
    try {
      final bookingModel = await remoteDataSource.createBooking();
      return Right(bookingModel.toEntity());
    } on DioException catch (e) {
      debugPrint("❌ DioException: ${e.message}");
      debugPrint("❌ DioException Type: ${e.type}");
      debugPrint("❌ DioException Response: ${e.response?.data}");
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() async {
    try {
      final bookingModels = await remoteDataSource.getBookings();
      final bookingEntities =
          bookingModels.map((model) => model.toEntity()).toList();
      return Right(bookingEntities);
    } on DioException catch (e) {
      debugPrint("❌ DioException: ${e.message}");
      debugPrint("❌ DioException Type: ${e.type}");
      debugPrint("❌ DioException Response: ${e.response?.data}");
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
