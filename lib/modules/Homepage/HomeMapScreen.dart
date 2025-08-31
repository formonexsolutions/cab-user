import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/HomeControllers/MapScreenController.dart';


class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller को instantiate करें
    final AppController controller = Get.put(AppController());

    return Scaffold(
      body: Obx(
            () => Stack(
          children: [
            // Google Map Widget
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator())
            else
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.carPosition.value,
                  zoom: 12.0,
                ),
                markers: controller.markers.value,
                myLocationEnabled: true,
              ),

            // Search Box और Buttons
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.pickupController,
                      decoration: InputDecoration(
                        hintText: 'Pickup Location',
                        prefixIcon: const Icon(Icons.location_pin, color: Colors.orange),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    TextField(
                      controller: controller.destinationController,
                      decoration: InputDecoration(
                        hintText: 'Where to?',
                        prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 'Confirm Ride' Button
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  controller.moveCar(); // Demo के लिए car को move करें
                  Get.snackbar(
                    'Ride Confirmed',
                    'Your ride is on its way!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Confirm Ride',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

