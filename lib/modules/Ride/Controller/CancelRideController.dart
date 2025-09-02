import 'package:get/get.dart';

class CancelRideController extends GetxController {
  // selected reason ko store karne ke liye
  final RxString selectedReason = ''.obs;
  // Other field me likhi hui value
  final RxString otherReasonText = ''.obs;

  void selectReason(String reason) {
    if (selectedReason.value == reason) {
      selectedReason.value = ''; // Agar dobara click ho toh deselect kar do
    } else {
      selectedReason.value = reason;
    }
    // Agar "Other" select nahi hai toh text field ko empty kar do
    if (reason != 'Other') {
      otherReasonText.value = '';
    }
  }

  void submitCancellation() {
    String finalReason = selectedReason.value;
    if (finalReason == 'Other') {
      finalReason = otherReasonText.value.isNotEmpty ? otherReasonText.value : 'No reason provided';
    }

    if (finalReason.isEmpty) {
      Get.snackbar("Error", "Please select a reason to cancel.");
      return;
    }

    // Yahan pe aap cancellation logic implement kar sakte hain
    // jaise ki API call
    print("Ride cancelled with reason: $finalReason");

    // Example navigation
    // Get.back();
    // Get.snackbar("Success", "Ride has been cancelled.");
  }
}