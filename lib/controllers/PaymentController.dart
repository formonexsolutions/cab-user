import 'package:flutter/material.dart';
import 'package:get/get.dart';


// A simple GetX Controller to manage state.
class PaymentController extends GetxController {
  final selectedPaymentMethod = 0.obs; // 0 for card, 1 for add new, etc.

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  void payNow() {
    // Implement payment logic here.
    // For this example, we'll just show a snackbar.
    Get.snackbar('Payment Successful', 'You have paid \$15.00',
        snackPosition: SnackPosition.BOTTOM);
  }
}