// lib/features/booking/domain/repository/booking_repository.dart

import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/bookings/domain/entity/booking_entity.dart'; // Assuming you are using dartz for Either

abstract class BookingRepository {
  Future<Either<Failure, BookingEntity>> createBooking();
  Future<Either<Failure, List<BookingEntity>>> getBookings();
}
