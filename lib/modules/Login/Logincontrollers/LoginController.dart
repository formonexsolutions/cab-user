import 'dart:async';
import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/Constants/api_messages.dart';
import '../../../core/Constants/storage_keys.dart';
import '../AuthServices/AuthService.dart';

class LoginController extends GetxController {
  RxInt timer = 60.obs;
  RxBool isResendButtonEnabled = false.obs;
  late Timer _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer.value = 60;
    isResendButtonEnabled.value = false;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        _countdownTimer.cancel();
        isResendButtonEnabled.value = true;
      }
    });
  }
  void resendCode() {
    startTimer();
  }


  // sing up method

  final box = GetStorage();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  RxBool isLoading = false.obs;
   final AuthService _authService = AuthService();

  Future<void> signUp() async {
    // Basic validation to ensure required fields are not empty.
    if (fullNameController.text.isEmpty || phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the required fields');
      return;
    }

    // Set loading state to true to show a loading indicator on the UI.
    isLoading.value = true;

    try {
      final result = await _authService.registerUser(
        name: fullNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        role: "passenger",
      );

      // Handle the API response based on your server's logic.
      if (result['message'] == ApiMessages.otpSentSuccessfully) {
        Get.snackbar('Success', result['message'], backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(AppRoutes.otpVerify);
      } else {
        Get.snackbar('Error', result['message'] ?? 'Registration failed.', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Catch any network or decoding errors and show a user-friendly message.
      Get.snackbar('Error', 'An unexpected error occurred: $e', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      // Set loading state back to false regardless of the outcome.
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the OTP.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final result = await _authService.verifyOtp(
        phone: phoneController.text, // Use the phone number from the sign-up screen
        otp: otpController.text,
      );

      if (result['message'] == ApiMessages.otpVerifiedSuccessfully) {
        Get.snackbar('Success', result['message'], backgroundColor: Colors.green, colorText: Colors.white);
        final user = result['user'];
        final token = result['token'];

        // 5 चीजें Get Storage में सेव करें
        box.write(StorageKeys.id, user['id']);
        box.write(StorageKeys.name, user['name']);
        box.write(StorageKeys.phone, user['phone']);
        box.write(StorageKeys.role, user['role']);
        box.write(StorageKeys.token, token);

        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar('Error', result['message'] ?? 'OTP verification failed.', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAuthentication() async {
    try {
      final result = await _authService.authenticateUser();

      if (result['tokenExpire'] == false) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.splash);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.splash);
    }
  }

  var isEmailMode = false.obs;

  Future<void> login() async {
    // Basic validation
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number.',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final result = await _authService.loginUser(
        phone: phoneController.text, // Format the phone number with country code
      );

      // Handle the API response
      if (result['message'] == ApiMessages.otpSentSuccessfully) {
        Get.snackbar('Success', result['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(AppRoutes.otpVerify);
      } else {
        Get.snackbar('Error', result['message'] ?? 'Login failed.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', '${ApiMessages.unexpectedError}: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    _countdownTimer.cancel();
    fullNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}