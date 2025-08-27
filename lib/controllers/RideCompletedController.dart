import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/app_colors.dart';


class RideCompletedController extends GetxController {
  final rating = 0.obs;
  final tipAmount = 0.obs;

  void setRating(int value) {
    rating.value = value;
  }

  void setTipAmount(int value) {
    tipAmount.value = value;
  }

  void completeRide() {
    // Logic to handle ride completion, e.g., API calls
    Get.snackbar('Ride Completed', 'Payment has been processed.');
    Get.toNamed(AppRoutes.paymentView);
  }

  void showCustomTipDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryYellow.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.attach_money_rounded,
                          color: AppColors.primaryYellow,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Enter Custom Tip',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headlineTextColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Premium input field
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFieldBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryYellow.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.headlineTextColor,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter amount in \$",
                          hintStyle: TextStyle(
                            color: AppColors.hintTextColor,
                          ),
                          prefixIcon: Icon(
                            Icons.attach_money_rounded,
                            color: AppColors.primaryYellow,
                          ),
                        ),
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            // tipAmount.value = int.tryParse(text) ?? 0;
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Premium action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Cancel button
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.subheadlineTextColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Confirm button with gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryYellow,
                              AppColors.buttonTextYellow,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryYellow.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: AppColors.buttonTextBlack,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'CONFIRM',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}


