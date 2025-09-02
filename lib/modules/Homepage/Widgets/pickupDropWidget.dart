import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/AppRoutes.dart';
import '../../../core/Utils/app_colors.dart';
import '../Controller/HomeController.dart';


Widget buildWhereToPanel(BuildContext context, ScrollController scrollController) {
  final controller = Get.find<HomeController>();

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
            buildQuickDestinationButton(
              label: 'Home',
              onTap: () {
                controller.selectDestination(result: {
                  "name": "स्वारगेट, Swargate PMPML Bus Stop Road, Swargate, Pune City, Pune, Maharashtra, 411009, India",
                  "lat": 18.4997453,
                  "long": 73.8574604
                });
              },
            ),
            buildQuickDestinationButton(
              label: 'Office',
              onTap: () {
                controller.selectDestination(result: {
                  "name": "स्वारगेट, Swargate PMPML Bus Stop Road, Swargate, Pune City, Pune, Maharashtra, 411009, India",
                  "lat": 18.4997453,
                  "long": 73.8574604
                });
              },
            ),
            buildQuickDestinationButton(
              label: 'Hotel',
              onTap: () {
                controller.selectDestination(result: {
                  "name": "स्वारगेट, Swargate PMPML Bus Stop Road, Swargate, Pune City, Pune, Maharashtra, 411009, India",
                  "lat": 18.4997453,
                  "long": 73.8574604
                });
              },
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
            Get.toNamed(AppRoutes.searchView);
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

Widget buildQuickDestinationButton({required String label, required VoidCallback onTap}) {
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

