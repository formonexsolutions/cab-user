// lib/core/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = "http://43.204.144.193:3000/api/";
  // static const String baseUrl = "http://192.168.0.103:3000/";
  static const String registerEndpoint = "${baseUrl}auth/register";
  static const String loginEndpoint = "${baseUrl}auth/login";
  static const String verifyOtpEndpoint = "${baseUrl}auth/verify-otp";
  static const String authUserEndpoint = "${baseUrl}auth/auth-user";
  static const String rideOpionsEndpoint = "${baseUrl}passenger/rides/options";
  static const String destinationEndpoint = "${baseUrl}geocode/search?query=";
}
