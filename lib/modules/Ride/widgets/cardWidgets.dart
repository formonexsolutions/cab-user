import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Utils/app_colors.dart';
import '../Controller/RideHistoryController.dart';

class RideCardWidget extends StatelessWidget {
  final Ride ride;

  const RideCardWidget({Key? key, required this.ride}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      // color: AppColors.backgroundLightGrey,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0), // Reduced vertical margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced overall padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ride.date,
              style: const TextStyle(
                fontSize: 12, // Reduced font size
                fontWeight: FontWeight.w500,
                color: AppColors.subheadlineTextColor,
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 8, color: AppColors.pickUpDotColor), // Reduced icon size
                    Container(
                      height: 25, // Reduced line height
                      width: 1.5, // Reduced line thickness
                      color: AppColors.dividerColor,
                    ),
                    Icon(Icons.circle, size: 8, color: AppColors.dropOffDotColor), // Reduced icon size
                  ],
                ),
                const SizedBox(width: 8), // Reduced spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ride.pickupAddress,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.headlineTextColor), // Reduced font size and boldness
                      ),
                      const SizedBox(height: 8), // Reduced spacing
                      Text(
                        ride.dropoffAddress,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.headlineTextColor), // Reduced font size and boldness
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 16, thickness: 0.5, color: AppColors.dividerColor), // Reduced divider height
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: AppColors.dividerColor), // Reduced icon size
                    const SizedBox(width: 4), // Reduced spacing
                    Text(
                      ride.time,
                      style: const TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor), // Reduced font size
                    ),
                    const SizedBox(width: 10), // Reduced spacing
                    const Icon(Icons.star, size: 16, color: AppColors.primaryYellow), // Reduced icon size
                    const SizedBox(width: 4), // Reduced spacing
                    Text(
                      ride.rating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 12, color: AppColors.subheadlineTextColor), // Reduced font size
                    ),
                  ],
                ),
                Text(
                  '\$${ride.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.headlineTextColor), // Reduced font size
                ),
              ],
            ),
            const SizedBox(height: 12), // Reduced spacing
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.snackbar('View Invoice', 'Viewing invoice for ${ride.date}');
                    },
                    icon: const Icon(Icons.description, size: 16), // Reduced icon size
                    label: const Text('View Invoice', style: TextStyle(fontSize: 12)), // Reduced font size
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryBlue,
                      side: const BorderSide(color: AppColors.primaryBlue, width: 1.0), // Reduced border thickness
                      padding: const EdgeInsets.symmetric(vertical: 10), // Reduced vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Reduced spacing
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.snackbar('Repeat Ride', 'Repeating ride from ${ride.pickupAddress} to ${ride.dropoffAddress}');
                    },
                    icon: const Icon(Icons.replay, size: 16), // Reduced icon size
                    label: const Text('Repeat Ride', style: TextStyle(fontSize: 12)), // Reduced font size
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryBlue,
                      side: const BorderSide(color: AppColors.primaryBlue, width: 1.0), // Reduced border thickness
                      padding: const EdgeInsets.symmetric(vertical: 10), // Reduced vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}