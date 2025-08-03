// lib/features/booking/domain/use_case/create_booking_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/bookings/domain/entity/booking_entity.dart';
import 'package:thrift_store/features/bookings/domain/repository/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository repository;

  CreateBookingUseCase({required this.repository});

  Future<Either<Failure, BookingEntity>> call() async {
    return await repository.createBooking();
  }
}
