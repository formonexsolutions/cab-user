import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../Services/Firestore_Service_Class.dart';
import '../../View/Homepage/RideDetailsView.dart';
import '../RideDetailsController.dart';

class HomeController extends GetxController {
  final RxString destination = ''.obs;
  final RxString selectedVehicle = 'Premium'.obs; // "Popular" vehicle ko default set karein
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final RxBool isRequestingRide = RxBool(false);
  final RxString rideStatus = 'initial'.obs;
  final RxBool isMapReady = false.obs;
  final RxBool isRideSelectionVisible = false.obs; // Naya variable
  RxBool isSearchingForRide = false.obs;

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
          child: const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );
    }
  }

  void onMapCreated(MapController controller) {
    mapController = controller;
    isMapReady.value = true;

    if (currentLocation.value != null) {
      mapController!.move(currentLocation.value!, 15.0);
    }
  }

  // Ab destination select hone ke baad ride selection panel show karein
  void selectDestination(String newDestination) {
    destination.value = newDestination;
    isRideSelectionVisible.value = true; // Panel ko visible karein
  }

  void selectVehicle(String vehicle) {
    selectedVehicle.value = vehicle;
  }

  // Back button press hone par state reset karein
  void hideRideSelection() {
    isRideSelectionVisible.value = false;
  }


  void requestRide() {
    isSearchingForRide.value = true;

    // Wait for 5 seconds to simulate searching for a ride
    Future.delayed(const Duration(seconds: 5), () {
      // After 5 seconds, change the state to hide the searching panel
      isSearchingForRide.value = false;

      // Navigate to the RideDetailsView and bind its controller
      Get.toNamed(AppRoutes.rideDetailsView);
    });
  }
  void cancelRide() {
    isSearchingForRide.value = false;
  }

}
