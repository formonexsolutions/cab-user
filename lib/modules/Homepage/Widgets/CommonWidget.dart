import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/AppRoutes.dart';
import '../../../Utils/app_colors.dart';
import '../Controller/HomeController.dart';

Widget buildCircularIconButton({
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


double getSheetSize() {
  final controller = Get.find<HomeController>();

  if (controller.isSearchingForRide.value) return 0.65;
  if (controller.isRideSelectionVisible.value) return 0.6;
  return 0.4;
}