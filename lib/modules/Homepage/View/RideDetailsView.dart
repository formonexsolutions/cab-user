import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../Utils/CustomDrawer.dart';
import '../../../controllers/RideDetailsController.dart';

class RideDetailsView extends GetView<RideDetailsController> {
  const RideDetailsView({super.key});

  Widget _buildOtpBox(String digit) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        digit,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RideDetailsController());

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          // Background Map Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main content area with white cards
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                      child: Column(
                        children: [
                          // Driver details card
                          _buildCard(
                            padding: const EdgeInsets.all(16),
                            child: Obx(() => Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    'https://i.pravatar.cc/150?img=68',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            controller.driverName.value,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.verified_rounded,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text('${controller.driverRating.value}', style: const TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        controller.carDetails.value,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          controller.carPlate.value,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),),
                          ),
                          const SizedBox(height: 16),

                          // OTP card
                          _buildCard(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Share OTP with driver',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 12),
                                Obx(
                                      () => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildOtpBox(controller.otp.value[0]),
                                      _buildOtpBox(controller.otp.value[1]),
                                      _buildOtpBox(controller.otp.value[2]),
                                      _buildOtpBox(controller.otp.value[3]),
                                      IconButton(
                                        icon: const Icon(Icons.copy, color: Colors.black),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Only share OTP after confirming driver details',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Distance and Track Ride card with progress bar
                          _buildCard(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.distanceAway.value.toStringAsFixed(1)} km away',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${controller.etaInMins.value} Min Away from You',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    )),
                                    ElevatedButton(
                                      onPressed: () => controller.trackRide(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFE03B),
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Text('Track Ride'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16), // Spacing between the row and the tracker
                                // The new progress tracker
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: 0.7, // This value is for demonstration. Adjust as needed.
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFE03B)),
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Estimated fare and Cancel Ride card
                          _buildCard(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Estimated fare',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () {
                                        // Logic for UPI payment
                                      },
                                      icon: const Icon(Icons.credit_card, size: 16),
                                      label: const Text('UPI'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        side: BorderSide(color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() => Text(
                                  '₹${controller.estimatedFare.value}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () => controller.cancelRide(),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      side: const BorderSide(color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text('Cancel Ride'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Call and Message buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => controller.callDriver(),
                                  icon: const Icon(Icons.call, color: Colors.white),
                                  label: const Text('Call Driver', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF67B543),
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => controller.messageDriver(),
                                  icon: const Icon(Icons.message),
                                  label: const Text('Message'),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    side: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header with Arriving status, back and menu buttons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                        icon: const Icon(Icons.arrow_back_ios_new),
                        color: Colors.black,
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                          () => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Driver is on the way',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Arriving in ${controller.etaInMins.value} mins',
                              style: const TextStyle(
                                color: Color(0xFF67B543),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
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
                      child: Builder(
                        builder: (BuildContext innerContext) {
                          return IconButton(
                            icon: const Icon(Icons.menu_rounded),
                            color: Colors.black,
                            onPressed: () {
                              // Use the 'innerContext' provided by the Builder
                              Scaffold.of(innerContext).openDrawer();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

