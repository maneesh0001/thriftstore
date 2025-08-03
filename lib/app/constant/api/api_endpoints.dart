class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/";
  static const String imageUrl = "http://10.0.2.2:5000/uploads/";
  // static const String baseUrl = "http://192.168.1.67:5000/api/";
  // static const String imageUrl = "http://192.168.1.67:5000/uploads/";
  static const String login = "${baseUrl}auth/login";
  static const String register = "${baseUrl}auth/signup";
  static const String uploadImage = "${baseUrl}auth/uploadImage";
  static const String resetPasswordRequest =
      "${baseUrl}auth/reset-password-request";
  static const String resetPassword = "${baseUrl}auth/reset-password";
  static const String deleteUser = "${baseUrl}auth/delete/";
  static const String getAllUsers = "${baseUrl}auth/getAllUsers/";
  static const String currentUser = "${baseUrl}auth/me";
  static const String updateUser = "${baseUrl}users";
  static const String createProduct = "${baseUrl}product/save";
  static const String getAllProducts = "${baseUrl}products/get";
  static const String getProductById =
      "${baseUrl}product/"; // append ID dynamically
  static const String updateProduct =
      "${baseUrl}product/"; // append ID dynamically
  static const String deleteProduct =
      "${baseUrl}product/"; // append ID dynamically
  static const String cart =
      "${baseUrl}cart"; // GET (fetch cart), POST (add to cart)
  static const String updateCartItem =
      "${baseUrl}cart"; // PUT or PATCH if applicable
  static const String addProductToCart =
      "${baseUrl}cart"; // POST to add a product to the cart
  static const String removeProductFromCart =
      "${baseUrl}cart/remove"; // DELETE with ID or body
  static const String clearCart = "${baseUrl}cart/clear";
  static const String createBooking = "${baseUrl}bookings";
  static const String getBookings = "${baseUrl}bookings";
}
