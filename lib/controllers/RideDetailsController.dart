import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

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
    Get.toNamed(AppRoutes.rideCompletedView);
  }

  void messageDriver() {
    // Add logic to open a messaging app or in-app chat
    Get.snackbar('Message Driver', 'Opening chat with $driverName');
  }

  void trackRide() {
    Get.toNamed(AppRoutes.trackDriver);
  }

  void cancelRide() {
    // Add logic to cancel the ride
    Get.toNamed(AppRoutes.cancelRidePage);
  }


  final RxString destination = ''.obs;
  final RxString selectedVehicle = 'Premium'.obs; // "Popular" vehicle ko default set karein
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  MapController? mapController;
  final RxSet<Marker> markers = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchLiveLocation();
  }

  Future<void> _fetchLiveLocation() async {
    await Future.delayed(const Duration(seconds: 2));
    currentLocation.value = const LatLng(18.5539, 73.9476); // Pune

    if (currentLocation.value != null) {
      markers.add(
        Marker(
          point: currentLocation.value!,
          width: 80,
          height: 80,
          child: Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );
    }
  }


  var selectedReason = 'Waiting for long time'.obs;
  var otherReasonText = ''.obs;

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  void updateOtherReason(String text) {
    otherReasonText.value = text;
  }
}