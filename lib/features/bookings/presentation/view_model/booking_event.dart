
import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class CreateBookingEvent extends BookingEvent {
  const CreateBookingEvent();
}

class FetchBookingsEvent extends BookingEvent {
  const FetchBookingsEvent();
}
