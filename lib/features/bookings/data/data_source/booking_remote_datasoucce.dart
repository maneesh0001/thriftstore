import 'package:dio/dio.dart';
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
import 'package:thrift_store/core/network/api_service.dart';
import 'package:thrift_store/features/bookings/data/model/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<BookingModel> createBooking();
  Future<List<BookingModel>> getBookings();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio _dio;

  BookingRemoteDataSourceImpl({required ApiService apiService}) : _dio = apiService.dio;

  @override
  Future<BookingModel> createBooking() async {
    try {
      // Backend's createBookingFromCart uses req.user.id from token,
      // so no need to send userId in the body.
      final response = await _dio.post(ApiEndpoints.createBooking);

      if (response.statusCode == 201) { // Assuming 201 Created on success
        print("Booking created successfully: ${response.data}");
        // --- MODIFICATION HERE ---
        // Access the 'booking' key from the response data, as the top-level
        // response contains a 'message' and a 'booking' object.
        if (response.data != null && response.data['booking'] != null) {
          return BookingModel.fromJson(response.data['booking']);
        } else {
          // Handle cases where 'booking' key might be missing or null
          print("Error: 'booking' data not found in response.");
          throw Exception("Booking data is missing from the response.");
        }
      } else {
        print("Failed to create booking: ${response.statusCode} - ${response.statusMessage}");
        throw Exception(response.statusMessage ?? "Failed to create booking.");
      }
    } on DioException catch (e) {
      print("DioError in createBooking: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Error type: ${e.type}");
      throw Exception(e.message ?? "An unknown Dio error occurred while creating booking.");
    } catch (e) {
      print("Generic error in createBooking: $e");
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BookingModel>> getBookings() async {
    try {
      // Backend's getBookings uses req.user.id from token,
      // so no need to send userId in the URL path.
      final response = await _dio.get(ApiEndpoints.getBookings);

      if (response.statusCode == 200) {
        print("Bookings fetched successfully: ${response.data}");
        // Backend response for getBookings is an array of booking objects
        final List<dynamic> bookingListJson = response.data;
        return bookingListJson.map((json) => BookingModel.fromJson(json)).toList();
      } else {
        print("Failed to fetch bookings: ${response.statusCode} - ${response.statusMessage}");
        throw Exception(response.statusMessage ?? "Failed to fetch bookings.");
      }
    } on DioException catch (e) {
      print("DioError in getBookings: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Error type: ${e.type}");
      throw Exception(e.message ?? "An unknown Dio error occurred while fetching bookings.");
    } catch (e) {
      print("Generic error in getBookings: $e");
      throw Exception(e.toString());
    }
  }
}