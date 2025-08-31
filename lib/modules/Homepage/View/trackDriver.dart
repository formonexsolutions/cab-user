import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../Utils/CustomDrawer.dart';
import '../../../Utils/app_colors.dart';
import '../../../controllers/RideDetailsController.dart';

const double _rideTimeBoxBottomPosition = 260.0;

class TrackDriver extends StatelessWidget {
  const TrackDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Get.find<>() is a standard and clean way to retrieve the controller.
    final RideDetailsController controller = Get.find<RideDetailsController>();

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          // This widget handles the map background and its dynamic state.
          _buildMapLayer(controller),

          // This widget builds the top app bar with the back and menu icons.
          _buildAppBar(),

          // This widget builds the floating box that shows the ride time.
          _buildRideTimeBox(),

          // This widget builds the detailed driver information card at the bottom.
          _buildDriverInfoCard(),
        ],
      ),
    );
  }

  /// Builds the main map layer, including the map tiles and markers.
  Widget _buildMapLayer(RideDetailsController controller) {
    return Obx(
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
    );
  }

  /// Builds the custom app bar with circular back and menu buttons.
  Widget _buildAppBar() {
    return Positioned(
      top: 40,
      left: 10,
      right: 10,
      child: Builder(
          builder: (BuildContext innerContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircularIconButton(
                icon: Icons.arrow_back_ios_new,
                onPressed: () => Get.back(),
              ),
              _buildCircularIconButton(
                icon: Icons.menu_rounded,
                onPressed: () { Scaffold.of(innerContext).openDrawer();},
              ),
            ],
          );
        }
      ),
    );
  }

  /// Helper function to create a circular icon button with a shadow.
  Widget _buildCircularIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: AppColors.primaryBlack,
        onPressed: onPressed,
      ),
    );
  }

  /// Builds the small "5 mins" ride time box.
  Widget _buildRideTimeBox() {
    return Positioned(
      bottom: _rideTimeBoxBottomPosition,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.dividerColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text('Your Ride', style: TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor)),
            Text(
              '5 mins',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.primaryYellow),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the bottom card with driver and ride details.
  Widget _buildDriverInfoCard() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDriverDetailsRow(),
            const SizedBox(height: 20),
            _buildActionButtonsRow(),
            const SizedBox(height: 20),
            _buildLocationRow(text: 'Shivajinagar, Pune', icon: Icons.location_on),
            const SizedBox(height: 10),
            _buildLocationRow(text: 'Baner, Pune', icon: Icons.location_on),
          ],
        ),
      ),
    );
  }

  /// Helper to build the row containing driver's picture, name, and car details.
  Widget _buildDriverDetailsRow() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/user.jpg'),
          radius: 30,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'James Wilson',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor),
              ),
              // Star rating row
              _StarRating(),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('Toyota Camry', style: TextStyle(fontSize: 14, color: AppColors.subheadlineTextColor)),
            Text('ABC 123', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor)),
          ],
        ),
      ],
    );
  }

  /// Helper to build the row containing 'Call Driver' and 'Cancel Ride' buttons.
  Widget _buildActionButtonsRow() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone),
            label: const Text('Call Driver'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.buttonTextBlack,
              side: const BorderSide(color: AppColors.buttonOutline),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Cancel Ride',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  /// Helper to build a single location row.
  Widget _buildLocationRow({required String text, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryYellow),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 16, color: AppColors.subheadlineTextColor)),
      ],
    );
  }
}

/// A simple widget for displaying a static star rating.
class _StarRating extends StatelessWidget {
  const _StarRating();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.star, color: AppColors.primaryYellow, size: 16),
        Text('4.9', style: TextStyle(color: AppColors.subheadlineTextColor)),
      ],
    );
  }
}
