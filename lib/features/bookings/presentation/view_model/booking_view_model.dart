// lib/features/booking/presentation/view_model/booking_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrift_store/features/bookings/domain/usecase/create_booking_usecase.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_event.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_state.dart' show BookingState, BookingStatus;

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUseCase _createBookingUseCase;

  BookingBloc({
    required CreateBookingUseCase createBookingUseCase,
    // required GetBookingsUseCase getBookingsUseCase,
  })  : _createBookingUseCase = createBookingUseCase,
        // _getBookingsUseCase = getBookingsUseCase,
        super(const BookingState()) {
    on<CreateBookingEvent>(_onCreateBooking);
    // on<FetchBookingsEvent>(_onFetchBookings);
  }

  Future<void> _onCreateBooking(
    CreateBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(status: BookingStatus.loading, error: null));
    final result = await _createBookingUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: BookingStatus.failure,
        error: failure.message,
      )),
      (booking) => emit(state.copyWith(
        status: BookingStatus.success,
        latestBooking: booking,
        // Optionally, refetch all bookings after creating one
        // This will trigger a new FetchBookingsEvent
      )),
    );
  }

  // Future<void> _onFetchBookings(
  //   FetchBookingsEvent event,
  //   Emitter<BookingState> emit,
  // ) async {
  //   emit(state.copyWith(status: BookingStatus.loading, error: null));
  //   final result = await _getBookingsUseCase();
  //   result.fold(
  //     (failure) => emit(state.copyWith(
  //       status: BookingStatus.failure,
  //       error: failure.message,
  //     )),
  //     (bookings) => emit(state.copyWith(
  //       status: BookingStatus.success,
  //       bookings: bookings,
  //     )),
  //   );
  // }
}
