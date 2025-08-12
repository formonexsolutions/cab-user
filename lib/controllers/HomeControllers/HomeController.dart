// lib/controllers/home_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Services/Firestore_Service_Class.dart';
// Firestore Service ko import karein

class HomeController extends GetxController {
  // Reactive variables to manage the state of the Home page
  final RxString destination = ''.obs;
  final RxString selectedVehicle = 'Sedan'.obs; // Default selected vehicle
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final RxBool isRequestingRide = RxBool(false);
  final RxString rideStatus = 'initial'.obs; // 'initial', 'finding_driver', 'on_the_way', 'arrived'

  // Map ke liye instance aur markers
  GoogleMapController? mapController;
  final Set<Marker> markers = {};

  final _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    // App start hone par live location fetch karein.
    _fetchLiveLocation();
  }

  /// Live location fetch karne ka simulation
  Future<void> _fetchLiveLocation() async {
    // Yahan aap 'geolocator' package ka use karke real location laa sakte hain.
    // Example:
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // currentLocation.value = LatLng(position.latitude, position.longitude);

    // Abhi ke liye, hum ek dummy location use kar rahe hain
    await Future.delayed(const Duration(seconds: 2));
    currentLocation.value = const LatLng(28.7041, 77.1025); // Delhi

    // Map par user ka marker add karein
    if (currentLocation.value != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('userLocation'),
          position: currentLocation.value!,
          infoWindow: const InfoWindow(title: 'Meri Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    }
  }

  /// Jab GoogleMap create ho jaye
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  /// User ne 'Where to?' mein destination set kiya hai
  void selectDestination(String newDestination) {
    destination.value = newDestination;
    print('Destination selected: $newDestination');
    // Is method mein aap Google Maps API se details fetch kar sakte hain.
  }

  /// User ne vehicle type select kiya hai
  void selectVehicle(String vehicle) {
    selectedVehicle.value = vehicle;
    print('Vehicle selected: $vehicle');
  }

  /// 'Request Ride' button par click karne par yeh method call hoga
  Future<void> requestRide() async {
    isRequestingRide.value = true;
    rideStatus.value = 'finding_driver';

    // Yahan par aap ride request ki logic implement karenge.
    // 1. Rider ki current location aur destination fetch karein.
    // 2. Nearest available drivers ko find karein (Firestore queries ka use karke).
    // 3. Ek naya 'ride' document create karein 'rides' collection mein.
    // 4. Driver ko push notification bhejkar ride ke liye alert karein.

    // Abhi ke liye, hum 5 second ka delay daalkar ride ko confirm hone ka simulation karte hain.
    await Future.delayed(const Duration(seconds: 5));

    rideStatus.value = 'on_the_way';
    isRequestingRide.value = false;

    Get.snackbar(
      'Ride Confirmed',
      '${selectedVehicle.value} aapki taraf aa raha hai.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    print('Ride requested: ${selectedVehicle.value} to ${destination.value}');
  }
}
