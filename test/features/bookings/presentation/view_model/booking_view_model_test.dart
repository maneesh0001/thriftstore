import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/bookings/domain/entity/booking_entity.dart';
import 'package:thrift_store/features/bookings/domain/usecase/create_booking_usecase.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_event.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_state.dart';
import 'package:thrift_store/features/bookings/presentation/view_model/booking_view_model.dart';

class MockCreateBookingUseCase extends Mock implements CreateBookingUseCase {}

void main() {
  late BookingBloc bookingBloc;
  late MockCreateBookingUseCase mockCreateBookingUseCase;

  setUp(() {
    mockCreateBookingUseCase = MockCreateBookingUseCase();
    bookingBloc = BookingBloc(createBookingUseCase: mockCreateBookingUseCase);
  });

  final tBooking = BookingEntity(
    id: 'booking_1',
    userId: 'user_1', items: [], totalPrice: 100,
    // Add other required fields here
  );

  group('CreateBookingEvent', () {
    blocTest<BookingBloc, BookingState>(
      'emits [loading, success] when booking creation succeeds',
      build: () {
        when(() => mockCreateBookingUseCase())
            .thenAnswer((_) async => Right(tBooking));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(CreateBookingEvent()),
      expect: () => [
        const BookingState(status: BookingStatus.loading, error: null),
        BookingState(status: BookingStatus.success, latestBooking: tBooking),
      ],
      verify: (_) {
        verify(() => mockCreateBookingUseCase()).called(1);
      },
    );

    blocTest<BookingBloc, BookingState>(
      'emits [loading, failure] when booking creation fails',
      build: () {
        when(() => mockCreateBookingUseCase())
            .thenAnswer((_) async => Left(ApiFailure(message: 'Failed')));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(CreateBookingEvent()),
      expect: () => [
        const BookingState(status: BookingStatus.loading, error: null),
        const BookingState(
          status: BookingStatus.failure,
          error: 'Failed',
        ),
      ],
      verify: (_) {
        verify(() => mockCreateBookingUseCase()).called(1);
      },
    );
  });
}
