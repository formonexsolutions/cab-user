import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Utils/app_colors.dart';
import '../Controller/CancelRideController.dart';

class CancelRideScreen extends StatelessWidget {
  const CancelRideScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final CancelRideController controller = Get.find<CancelRideController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryBlack),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Cancel Ride',
          style: TextStyle(
            color: AppColors.headlineTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Please Select the reason of cancellation',
              style: TextStyle(
                color: AppColors.subheadlineTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),

            // Cancellation reasons ki list
            _buildReasonOption(
                controller, 'Waiting for long time'),
            _buildReasonOption(
                controller, 'Unable to connect driver'),
            _buildReasonOption(
                controller, 'Driver denied to go to the destination'),
            _buildReasonOption(
                controller, 'Driver denied to come to pickup'),
            _buildReasonOption(
                controller, 'Wrong address shown'),
            _buildReasonOption(
                controller, 'The price is not reasonable'),

            const SizedBox(height: 20),
            // "Other" reason ke liye text field
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.backgroundLightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (text) => controller.otherReasonText.value = text,
                decoration: const InputDecoration(
                  hintText: 'Other',
                  hintStyle: TextStyle(color: AppColors.hintTextColor),
                  border: InputBorder.none,
                ),
                maxLines: 4,
                style: const TextStyle(color: AppColors.headlineTextColor),
              ),
            ),
            const Spacer(),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => controller.submitCancellation(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: AppColors.buttonTextBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonOption(CancelRideController controller, String reason) {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.selectReason(reason),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: controller.selectedReason.value == reason
                ? AppColors.backgroundLightGrey // Selected hone par grey background
                : AppColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: controller.selectedReason.value == reason
                  ? AppColors.primaryYellow // Selected hone par yellow border
                  : AppColors.dividerColor,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Checkbox ko manually banaya gaya hai jaisa image mein hai
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: controller.selectedReason.value == reason
                      ? AppColors.greenAccent
                      : AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: controller.selectedReason.value == reason
                        ? AppColors.greenAccent
                        : AppColors.dividerColor,
                    width: 1.5,
                  ),
                ),
                child: controller.selectedReason.value == reason
                    ? const Icon(
                  Icons.check,
                  size: 14,
                  color: AppColors.primaryWhite,
                )
                    : null,
              ),
              const SizedBox(width: 15),
              Text(
                reason,
                style: const TextStyle(
                  color: AppColors.headlineTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}