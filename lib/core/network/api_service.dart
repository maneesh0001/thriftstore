// lib/core/network/api_service.dart

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:thrift_store/app/constant/api/api_endpoints.dart';
import 'package:thrift_store/core/network/dio_error_interceptor.dart';
import 'package:thrift_store/app/shared_prefs/user_shared_prefs.dart'; // Import UserSharedPrefs

class ApiService {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs; // Add UserSharedPrefs dependency

  Dio get dio => _dio; // Getter to expose the configured Dio instance

  ApiService(this._dio, this._userSharedPrefs) { // Accept UserSharedPrefs in constructor
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      // Add the authentication interceptor FIRST, so it runs before other interceptors
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Retrieve the token from shared preferences
            final token = await _userSharedPrefs.getUserData().then(
              (result) => result.fold(
                (failure) {
                  print('Auth Interceptor: Failed to retrieve token: ${failure.message}');
                  return null;
                },
                (userData) => userData.token, // Assuming 'token' exists in UserData
              ),
            );

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
              print('Auth Interceptor: Added Authorization header for ${options.path}'); // Debugging
            } else {
              print('Auth Interceptor: No token found for request to ${options.path}'); // Debugging
            }
            return handler.next(options); // Continue with the request
          },
          onError: (DioException e, handler) {
            if (e.response?.statusCode == 401) {
              // Handle 401 specifically: e.g., navigate to login, refresh token
              print("Auth Interceptor: HTTP 401 Unauthorized for ${e.requestOptions.path}. Message: ${e.response?.data['message'] ?? 'No message'}");
              // You might want to trigger a logout or token refresh flow here.
              // For now, we'll just let the error propagate.
            }
            return handler.next(e); // Pass the error along
          },
        ),
      )
      ..interceptors.add(DioErrorInterceptor()) // Your custom error interceptor
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      )
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }
}