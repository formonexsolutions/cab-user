import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../Controller/HomeController.dart';


Widget buildSearchingPanel(BuildContext context, ScrollController scrollController) {
  final controller = Get.find<HomeController>();

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
