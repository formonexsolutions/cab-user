import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:car_travel/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/CustomDrawer.dart';
import '../../controllers/HomeControllers/HomeController.dart';
import 'package:flutter_map/flutter_map.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
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
            right: 20,
            child: SafeArea(
              child: Builder(
                builder: (BuildContext innerContext) {
                  return Obx(
                        () {
                      if (controller.isRideSelectionVisible.value) {
                        // Condition 2: Show back button on left, menu on right
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            _buildCircularIconButton(
                              icon: Icons.arrow_back_ios,
                              onPressed: () => controller.hideRideSelection(),
                            ),
                            // Menu Button for the RIGHT drawer
                            _buildCircularIconButton(
                              icon: Icons.menu,
                              onPressed: () => Scaffold.of(innerContext).openDrawer(),
                            ),
                          ],
                        );
                      } else {
                        // Condition 1: Show single menu button on left
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: _buildCircularIconButton(
                            icon: Icons.menu,
                            onPressed: () => Scaffold.of(innerContext).openDrawer(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Obx(() {
            final size = _getSheetSize();
            return DraggableScrollableSheet(
              initialChildSize: size,
              minChildSize: size,
              maxChildSize: size,
              builder: (BuildContext context, ScrollController scrollController) {
                return Obx(() {
                  if (controller.isSearchingForRide.value) {
                    return _buildSearchingPanel(context, scrollController);
                  } else if (controller.isRideSelectionVisible.value) {
                    return _buildVehicleSelectionPanel(context, scrollController);
                  } else {
                    return _buildWhereToPanel(context, scrollController);
                  }
                });
              },
            );
          })

        ],
      ),
    );
  }

  Widget _buildCircularIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
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
          icon,
          color: AppColors.primaryBlack,
        ),
      ),
    );
  }


  double _getSheetSize() {
    if (controller.isSearchingForRide.value) return 0.47;
    if (controller.isRideSelectionVisible.value) return 0.47;
    return 0.3;
  }



  Widget _buildQuickDestinationButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
        decoration: BoxDecoration(
          color: AppColors.backgroundLightGrey,
          borderRadius: BorderRadius.circular(15), // Smaller radius
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, color: AppColors.iconColor, size: 16), // Smaller icon
            const SizedBox(width: 6), // Reduced spacing
            Text(
              label,
              style: const TextStyle(
                fontSize: 12, // Reduced font size
                color: AppColors.headlineTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildVehicleSelectionPanel(BuildContext context, ScrollController scrollController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0), // Reduced padding
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), // Smaller radius
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8, // Reduced blur
            offset: Offset(0, -4), // Reduced offset
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              height: 2, // Smaller height
              width: 30, // Smaller width
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8), // Reduced spacing
          // Vehicle Options List
          _buildVehicleOption(
            type: 'Economy',
            price: '\$1.99',
            eta: '2 min',
            seats: '6 Seats',
          ),
          const SizedBox(height: 8), // Reduced spacing
          _buildVehicleOption(
            type: 'Premium',
            price: '\$1.99',
            eta: '2 min',
            seats: '4 Seats',
            isPopular: true,
          ),
          const SizedBox(height: 8), // Reduced spacing
          _buildVehicleOption(
            type: 'Carpool',
            price: '\$1.99',
            eta: '2 min',
            seats: '6 Seats',
          ),
          const SizedBox(height: 20), // Reduced spacing
          SizedBox(
            width: double.infinity, // full width
            height: 45, // 👈 chhoti height set ki
            child: ElevatedButton(
              onPressed: () {
                controller.requestRide();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero, // important for gradient
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // pill shape
                ),
                backgroundColor: Colors.transparent, // remove default
                shadowColor: Colors.transparent, // remove shadow
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFF176), // light yellow (left)
                      Color(0xFFFFD600), // dark yellow (right)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Confirm Ride',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // text color
                    ),
                  ),
                ),
              ),
            ),
          )
          // Confirm Ride Button
          // ElevatedButton(
          //   onPressed: () {
          //     controller.requestRide();
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColors.buttonYellow,
          //     foregroundColor: AppColors.buttonTextBlack,
          //     padding: const EdgeInsets.symmetric(vertical: 14), // Reduced padding
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12), // Smaller radius
          //     ),
          //   ),
          //   child: const Text('Confirm Ride', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Smaller font size
          // ),
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
                padding: const EdgeInsets.all(12), // Reduced padding
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(12), // Smaller radius
                  border: isSelected ? Border.all(color: AppColors.buttonOutline, width: 1.5) : Border.all(color: AppColors.dividerColor, width: 0.5), // Smaller border width
                  boxShadow: [
                    BoxShadow(
                      color: isSelected ? AppColors.primaryYellow.withOpacity(0.1) : Colors.transparent,
                      blurRadius: 8, // Reduced blur
                      offset: const Offset(0, 4), // Reduced offset
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50, // Smaller width
                      height: 50, // Smaller height
                      child: Image.asset('assets/images/carLogo.png'),
                    ),
                    const SizedBox(width: 12), // Reduced spacing
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type,
                            style: const TextStyle(
                              fontSize: 16, // Reduced font size
                              fontWeight: FontWeight.bold,
                              color: AppColors.headlineTextColor,
                            ),
                          ),
                          const SizedBox(height: 2), // Reduced spacing
                          Row(
                            children: [
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 14, // Reduced font size
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.headlineTextColor,
                                ),
                              ),
                              const SizedBox(width: 6), // Reduced spacing
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.access_time, size: 14, color: AppColors.dividerColor), // Smaller icon
                                  const SizedBox(width: 2), // Reduced spacing
                                  Text(eta, style: const TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor)), // Reduced font size
                                ],
                              ),
                              const SizedBox(width: 6),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.person, size: 14, color: AppColors.dividerColor), // Smaller icon
                                  const SizedBox(width: 2), // Reduced spacing
                                  Text(seats, style: const TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor)), // Reduced font size
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 16, // Smaller width
                      height: 16, // Smaller height
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primaryYellow : AppColors.dividerColor,
                          width: 1.5, // Smaller border width
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Reduced padding
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12), // Smaller radius
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        color: AppColors.primaryBlue.withOpacity(0.7),
                        fontSize: 10, // Reduced font size
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0), // Reduced horizontal padding
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Smaller radius
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8, // Reduced blur
            offset: Offset(0, -4), // Reduced offset
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              height: 4, // Smaller height
              width: 30, // Smaller width
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 15), // Reduced vertical spacing
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
              _buildQuickDestinationButton(
                label: 'Gym',
                onTap: () => controller.selectDestination('Gym'),
              ),
            ],
          ),
          const SizedBox(height: 15), // Reduced vertical spacing
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(8), // Smaller radius
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.iconColor, size: 20), // Smaller icon
                const SizedBox(width: 8), // Reduced spacing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Location',
                      style: TextStyle(
                        fontSize: 10, // Reduced font size
                        color: AppColors.subheadlineTextColor,
                      ),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    const Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 14, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: AppColors.headlineTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12), // Reduced vertical spacing
          InkWell(
            onTap: () async {
              final selectedDestination = await Get.toNamed(AppRoutes.searchView);
              if (selectedDestination != null) {
                controller.selectDestination(selectedDestination);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(8), // Smaller radius
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.dividerColor, size: 20), // Smaller icon
                  const SizedBox(width: 8), // Reduced spacing
                  Expanded(
                    child: Obx(() => Text(
                      controller.destination.value.isEmpty
                          ? 'Where to?'
                          : controller.destination.value,
                      style: TextStyle(
                        fontSize: 14, // Reduced font size
                        color: controller.destination.value.isEmpty ? AppColors.hintTextColor : AppColors.headlineTextColor,
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15), // Reduced vertical spacing
        ],
      ),
    );
  }



  Widget _buildSearchingPanel(BuildContext context, ScrollController scrollController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0), // Reduced padding
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), // Smaller radius
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8, // Reduced blur
            offset: Offset(0, -4), // Reduced offset
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        children: [
          // Panel heading
          LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: AppColors.backgroundFaintYellow,
          ),
          SizedBox(height: 5,),
          Column(
            children: [
               SizedBox(
                width: 70, // Smaller width
                height: 70, // Smaller height
                child: Image.asset("assets/images/serchGlass.png"), // Smaller stroke width
              ),
               const Text(
                'Searching for cars nearby',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor), // Reduced font size
              ),
              const SizedBox(height: 2), // Reduced spacing
              Text(
                'Please wait a couple of minutes...',
                style: TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor), // Reduced font size
              ),
            ],
          ),
          const SizedBox(height: 10), // Reduced spacing

          // Location details
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primaryBlack, size: 20), // Smaller icon
                  Container(
                    width: 2,
                    height: 40, // Reduced height
                    color: AppColors.dividerColor,
                  ),
                  const Icon(Icons.location_on, color: AppColors.primaryYellow, size: 20), // Smaller icon
                ],
              ),
              const SizedBox(width: 12), // Reduced spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shivajinagar, Pune',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Reduced font size
                    ),
                    const SizedBox(height: 20), // Reduced spacing
                    Text(
                      'ABZ Baner, Pune',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Reduced font size
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Reduced spacing

          // Price and Edit/Cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '₹',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.buttonTextYellow), // Reduced font size
                  ),
                  const SizedBox(width: 2), // Reduced spacing
                  const Text(
                    '230',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.buttonTextYellow), // Reduced font size
                  ),
                  const SizedBox(width: 6), // Reduced spacing
                  Text(
                    '(Premium)',
                    style: TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor), // Reduced font size
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  // Logic to edit ride details
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.backgroundFaintYellow.withOpacity(0.3),
                  foregroundColor: AppColors.linkTextColor,
                  side: const BorderSide(color: AppColors.linkTextColor, width: 1), // Smaller border width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Smaller radius
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
                ),
                child: const Text('Edit details...', style: TextStyle(fontSize: 12)), // Reduced font size
              ),
            ],
          ),
          const SizedBox(height: 16), // Reduced spacing

          // Cancel Ride Button
          ElevatedButton(
            onPressed: () {
              controller.cancelRide();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonYellow,
              foregroundColor: AppColors.buttonTextBlack,
              padding: const EdgeInsets.symmetric(vertical: 14), // Reduced padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Smaller radius
              ),
            ),
            child: const Text('Cancel Ride', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Reduced font size
          ),
        ],
      ),
    );
  }

}