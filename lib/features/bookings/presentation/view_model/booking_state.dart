// lib/features/booking/presentation/view_model/booking_state.dart

import 'package:equatable/equatable.dart';
import 'package:thrift_store/features/bookings/domain/entity/booking_entity.dart';

enum BookingStatus { initial, loading, success, failure }

class BookingState extends Equatable {
  final BookingStatus status;
  final List<BookingEntity> bookings;
  final String? error;
  final BookingEntity? latestBooking; // To show details of the newly created booking

  const BookingState({
    this.status = BookingStatus.initial,
    this.bookings = const [],
    this.error,
    this.latestBooking,
  });

  BookingState copyWith({
    BookingStatus? status,
    List<BookingEntity>? bookings,
    String? error,
    BookingEntity? latestBooking,
  }) {
    return BookingState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      error: error, // Allow null to clear error
      latestBooking: latestBooking, // Allow null to clear
    );
  }

  @override
  List<Object?> get props => [status, bookings, error, latestBooking];
}
