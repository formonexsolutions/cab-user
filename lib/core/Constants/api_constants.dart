// lib/core/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = "http://43.204.144.193:3000/api/";
  // static const String baseUrl = "http://192.168.0.103:3000/";
  static const String registerEndpoint = "auth/register";
  static const String loginEndpoint = "auth/login";
  static const String verifyOtpEndpoint = "auth/verify-otp";
  static const String authUserEndpoint = "auth/auth-user";
  static const String rideOpionsEndpoint = "passenger/rides/options";
  static const String destinationEndpoint = "geocode/search?query=";

}
