import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:car_travel/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/HomeControllers/HomeController.dart';
import 'package:flutter_map/flutter_map.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
                () => controller.currentLocation.value == null
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: controller.currentLocation.value!,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.car_travel',
                ),
                MarkerLayer(
                  markers: controller.markers.toList(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: SafeArea(
              child: Obx(
                    () => InkWell(
                  onTap: () {
                    if (controller.isRideSelectionVisible.value) {
                      controller.hideRideSelection();
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      controller.isRideSelectionVisible.value
                          ? Icons.arrow_back_ios
                          : Icons.menu,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Obx(
                    () {
                  if (controller.isSearchingForRide.value) {
                    return _buildSearchingPanel(context, scrollController);
                  } else if (controller.isRideSelectionVisible.value) {
                    return _buildVehicleSelectionPanel(context, scrollController);
                  } else {
                    return _buildWhereToPanel(context, scrollController);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDestinationButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.iconColor),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleSelectionPanel(BuildContext context, ScrollController scrollController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Vehicle Options List
          _buildVehicleOption(
            type: 'Economy',
            price: '\$1.99',
            eta: '2 min',
            seats: '6 Seats',
          ),
          const SizedBox(height: 10),
          _buildVehicleOption(
            type: 'Premium',
            price: '\$1.99',
            eta: '2 min',
            seats: '4 Seats',
            isPopular: true,
          ),
          const SizedBox(height: 10),
          _buildVehicleOption(
            type: 'Carpool',
            price: '\$1.99',
            eta: '2 min',
            seats: '6 Seats',
          ),
          const SizedBox(height: 30),
          // Confirm Ride Button
          ElevatedButton(
            onPressed: () {
              controller.requestRide();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonYellow,
              foregroundColor: AppColors.buttonTextBlack,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Confirm Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOption({
    required String type,
    required String price,
    required String eta,
    required String seats,
    bool isPopular = false,
  }) {
    return Obx(
          () {
        bool isSelected = controller.selectedVehicle.value == type;
        return InkWell(
          onTap: () => controller.selectVehicle(type),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(15),
                  border: isSelected ? Border.all(color: AppColors.buttonOutline, width: 2) : Border.all(color: AppColors.dividerColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected ? AppColors.primaryYellow.withOpacity(0.1) : Colors.transparent,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/images/carLogo.png'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.headlineTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.headlineTextColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.access_time, size: 16, color: AppColors.dividerColor),
                                  const SizedBox(width: 4),
                                  Text(eta, style: const TextStyle(color: AppColors.subheadlineTextColor)),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.person, size: 16, color: AppColors.dividerColor),
                                  const SizedBox(width: 4),
                                  Text(seats, style: const TextStyle(color: AppColors.subheadlineTextColor)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primaryYellow : AppColors.dividerColor,
                          width: 2,
                        ),
                        color: isSelected ? AppColors.primaryYellow : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPopular)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        color: AppColors.primaryYellow.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWhereToPanel(BuildContext context, ScrollController scrollController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickDestinationButton(
                label: 'Home',
                onTap: () => controller.selectDestination('Home'),
              ),
              _buildQuickDestinationButton(
                label: 'Office',
                onTap: () => controller.selectDestination('Office'),
              ),
              _buildQuickDestinationButton(
                label: 'Hotel',
                onTap: () => controller.selectDestination('Hotel'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.iconColor),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Location',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.subheadlineTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headlineTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              final selectedDestination = await Get.toNamed(AppRoutes.searchView);
              if (selectedDestination != null) {
                controller.selectDestination(selectedDestination);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.dividerColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() => Text(
                      controller.destination.value.isEmpty
                          ? 'Where to?'
                          : controller.destination.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.destination.value.isEmpty ? AppColors.hintTextColor : AppColors.headlineTextColor,
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchingPanel(BuildContext context, ScrollController scrollController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Panel heading
          Column(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(color: AppColors.primaryYellow, strokeWidth: 5),
              ),
              const SizedBox(height: 16),
              const Text(
                'Searching for cars nearby',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor),
              ),
              const SizedBox(height: 4),
              Text(
                'Please wait a couple of minutes...',
                style: TextStyle(fontSize: 14, color: AppColors.subheadlineTextColor),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Location details
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primaryBlack, size: 24),
                  Container(
                    width: 2,
                    height: 50,
                    color: AppColors.dividerColor,
                  ),
                  const Icon(Icons.location_on, color: AppColors.primaryYellow, size: 24),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shivajinagar, Pune', // Replace with dynamic pickup location
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'ABZ Baner, Pune', // Replace with dynamic destination
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Price and Edit/Cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '₹',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '230',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(Economy)',
                    style: TextStyle(fontSize: 14, color: AppColors.subheadlineTextColor),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  // Logic to edit ride details
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.linkTextColor,
                  side: const BorderSide(color: AppColors.linkTextColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text('Edit details...', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Cancel Ride Button
          ElevatedButton(
            onPressed: () {
              controller.cancelRide();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonYellow,
              foregroundColor: AppColors.buttonTextBlack,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Cancel Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

}