import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../Controller/HomeController.dart';

Widget buildVehicleSelectionPanel(BuildContext context, ScrollController scrollController) {
  final controller = Get.find<HomeController>();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: AppColors.primaryWhite,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: const Offset(0, -5),
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
        // Vehicle Options List
        Obx(() {
          if (controller.isLoading.value) {
            return const Padding(
              padding: EdgeInsets.all(20), // Added padding to match the first code
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.vehicleOptions.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20), // Added padding to match the first code
              child: Center(child: Text('No ride options available')),
            );
          }

          return ListView.builder(
            shrinkWrap: true, // Added shrinkWrap to handle ListView inside another scrollable widget
            physics: const NeverScrollableScrollPhysics(), // Prevent inner ListView from scrolling
            padding: const EdgeInsets.symmetric(vertical: 10), // Updated padding
            itemCount: controller.vehicleOptions.length,
            itemBuilder: (context, index) {
              final option = controller.vehicleOptions[index];
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: buildVehicleOption(
                  type: option.type,
                  price: option.price,
                  eta: option.eta,
                  seats: option.seats.toString(),
                  isPopular: option.isPopular,
                ),
              );
            },
          );
        }),

        const SizedBox(height: 10),
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
        const SizedBox(height: 20), // Added spacing at the bottom
      ],
    ),
  );
}

Widget buildVehicleOption({
  required String type,
  required String price,
  required String eta,
  required String seats,
  bool isPopular = false,
}) {
  final controller = Get.find<HomeController>();

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
                            Flexible(
                              child: AutoSizeText(
                                price,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.headlineTextColor,
                                ),
                                maxLines: 1,
                                minFontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.access_time, size: 16, color: AppColors.dividerColor),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: AutoSizeText(
                                      eta,
                                      style: const TextStyle(color: AppColors.subheadlineTextColor),
                                      maxLines: 1,
                                      minFontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.person, size: 16, color: AppColors.dividerColor),
                                  const SizedBox(width: 4),
                                  Text(seats, style: const TextStyle(color: AppColors.subheadlineTextColor)),
                                ],
                              ),
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