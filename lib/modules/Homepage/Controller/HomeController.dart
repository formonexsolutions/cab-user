import 'dart:convert';
import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../controllers/GlobalController/globalController.dart';
import '../../../core/Constants/api_constants.dart';
import '../models/VehicleOption.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();


  final RxString destination = ''.obs;
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
    getLocation();
  }


  var currentLatitude = 0.0.obs;
  var currentLongitude = 0.0.obs;

  void getLocation() async {
    try {
      // Check if location services are ON
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        Get.snackbar("Location Service", "Please enable location services.");
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission -> this triggers system popup
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Permission Denied", "Please allow location access.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Cannot request again, open app settings
        Get.snackbar(
          "Permission Denied Forever",
          "Please enable location permission from settings.",
        );
        await Geolocator.openAppSettings();
        return;
      }

      // If permissions granted -> fetch location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;

      _fetchLiveLocation();
    } catch (e) {
      Get.snackbar("Error", "Could not get location: $e");
    }
  }

  Future<void> _fetchLiveLocation() async {
    await Future.delayed(const Duration(seconds: 2));
    currentLocation.value = LatLng(currentLatitude.value, currentLongitude.value); // Pune

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



  /// select destination

  var pickupAddress = 'Current Location'.obs;
  var pickupCoordinates = [0.0, 0.0].obs; // [longitude, latitude]
  var dropoffAddress = 'Shivaji Nagar, Pune'.obs;
  var dropoffCoordinates = [0.0, 0.0].obs; // [longitude, latitude]

  void selectDestination({required Map<String, dynamic> result}) {
    pickupAddress.value = "";
    pickupCoordinates.value = [currentLatitude.value, currentLongitude.value];

    dropoffAddress.value = result['name'];
    dropoffCoordinates.value = [result['long'], result['lat']];

    isRideSelectionVisible.value = true;
    fetchRideOptions();
  }


  /// fetch vehicle details premium carpool ...
  var vehicleOptions = <VehicleOption>[].obs;
  final RxString selectedVehicle = 'Premium'.obs;
  var isLoading = false.obs;

  Future<void> fetchRideOptions() async {
    isLoading.value = true;
    final url = "${ApiConstants.baseUrl}passenger/rides/options";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${globalController.token.value}",
        },
        body: jsonEncode({
          "pickup": {
            "address": pickupAddress.value,
            "location": {
              "type": "Point",
              "coordinates": pickupCoordinates.value,
            }
          },
          "dropoff": {
            "address":  dropoffAddress.value,
            "location": {
              "type": "Point",
              "coordinates":dropoffCoordinates.value,
            }
          },
          "radius": 0.1
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          vehicleOptions.value = List<VehicleOption>.from(
            data['data'].map((x) => VehicleOption.fromJson(x)),
          );
        }
      } else {
        Get.snackbar("Error", "Failed to fetch ride options");
      }
    } catch (e) {
      Get.snackbar("Error test", e.toString());
    } finally {
      isLoading.value = false;
    }
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
