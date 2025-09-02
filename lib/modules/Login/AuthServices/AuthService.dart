import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/Constants/api_constants.dart';
import '../../../core/Constants/storage_keys.dart';


class AuthService {
  final box = GetStorage();

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String phone,
    required String role,
  })
  async {
    final url = Uri.parse(ApiConstants.registerEndpoint);

    final Map<String, dynamic> requestBody = {
      'name': name,
      'email': email,
      'phone': phone,
      'role': "passenger",
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check for a successful status code before decoding
      if (response.statusCode == 200) {
        // If successful, the response is Base64 encoded
        final String rawResponseBody = response.body;
        print("#########################################################$rawResponseBody");

        final String decodedData = utf8.decode(base64.decode(rawResponseBody));
        return jsonDecode(decodedData);
      } else {
        // If not successful, the response is plain JSON
        final String errorBody = response.body;
        print("#########################################################erro####$errorBody");
        return jsonDecode(errorBody);
      }
    } catch (e) {
      // Catch network or other exceptions
      throw Exception('Failed to register: $e');
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  })
  async {
    final url = Uri.parse(ApiConstants.verifyOtpEndpoint);

    final Map<String, dynamic> requestBody = {
      'phone': "$phone",
      'otp': otp,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check for a successful status code
      if (response.statusCode == 200) {
        // If successful, the response is Base64 encoded
        final String rawResponseBody = response.body;
        final String decodedData = utf8.decode(base64.decode(rawResponseBody));
        return jsonDecode(decodedData);
      } else {
        // If not successful, the response is plain JSON
        final String errorBody = response.body;
        return jsonDecode(errorBody);
      }
    } catch (e) {
      throw Exception('Failed to verify OTP or decode response: $e');
    }
  }

  Future<Map<String, dynamic>> authenticateUser() async {
    final url = Uri.parse(ApiConstants.authUserEndpoint);
    // Read the stored token
    final token = box.read(StorageKeys.token);

    if (token == null) {
      throw Exception('No token found. User is not logged in.');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
        },
      );

      // Check for a successful status code
      if (response.statusCode == 200) {
        // Response is Base64 encoded, so decode it
        final String rawResponseBody = response.body;
        final String decodedData = utf8.decode(base64.decode(rawResponseBody));
        return jsonDecode(decodedData);
      } else {
        // Handle a non-successful response (e.g., invalid token)
        final String errorBody = response.body;
        return jsonDecode(errorBody);
      }
    } catch (e) {
      throw Exception('Failed to authenticate user: $e');
    }
  }


  Future<Map<String, dynamic>> loginUser({
    required String phone,
  })
  async {
    final url = Uri.parse(ApiConstants.loginEndpoint);

    final Map<String, dynamic> requestBody = {
      'phone': phone,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Assuming the response is Base64 encoded, just like the register and verify-otp APIs.
      if (response.statusCode == 200) {
        final String rawResponseBody = response.body;
        final String decodedData = utf8.decode(base64.decode(rawResponseBody));
        return jsonDecode(decodedData);
      } else {
        // If there's an error, assume a plain JSON response
        final String errorBody = response.body;
        return jsonDecode(errorBody);
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }


}