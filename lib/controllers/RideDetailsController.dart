import 'package:get/get.dart';

class RideDetailsController extends GetxController {

  // Reactive variables to hold the ride details
  final driverName = 'Chetan Patil'.obs;
  final driverRating = 4.92.obs;
  final carDetails = 'White Tesla Model 3'.obs;
  final carPlate = 'ABC 123'.obs;
  final otp = '2458'.obs;
  final distanceAway = 1.2.obs;
  final etaInMins = 5.obs;
  final estimatedFare = '230'.obs;
  final driverIsOnTheWay = true.obs; // To manage the UI state

  void callDriver() {
    // Add logic to call the driver
    Get.snackbar('Calling Driver', 'Initiating call to $driverName');
  }

  void messageDriver() {
    // Add logic to open a messaging app or in-app chat
    Get.snackbar('Message Driver', 'Opening chat with $driverName');
  }

  void trackRide() {
    // Add logic to track the ride on the map
    Get.snackbar('Tracking Ride', 'Showing live location of $driverName');
  }

  void cancelRide() {
    // Add logic to cancel the ride
    Get.snackbar('Ride Cancelled', 'Your ride has been cancelled.');
  }
}