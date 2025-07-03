class ApiEndpoints {
  ApiEndpoints._();

  static const connectionTimeoutDuration = Duration(seconds: 1000);
  static const recieveTimeoutDuration = Duration(seconds: 1000);

  static const String serverUri = 'http://10.0.2.2:5000';

  static const String baseUrl = '$serverUri/api/';

  static const String login = 'auth/login';

  static const String register = 'auth/signup';
}
