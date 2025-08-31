import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Utils/app_colors.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: <Widget>[
          // Main Image
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Image.asset(
              'assets/images/Png01.png',
              height: screenHeight * 0.3,
              fit: BoxFit.contain,
            ),
          ),

          // Text Content
          Positioned(
            top: screenHeight * 0.5,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Column(
              children: <Widget>[
                Text(
                  'Where your journey begins',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headlineTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Your journey starts the moment you tap.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.subheadlineTextColor,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Indicators (Modified)
          Positioned(
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.1,
            child: Row(
              children: [
                // Active indicator
                Container(
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryYellow,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppColors.buttonTextBlack,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                // Inactive indicators
                Container(
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.dividerColor.withOpacity(0.3),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.dividerColor.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),

          // Next Button
          Positioned(
            bottom: screenHeight * 0.05,
            right: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.splash2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: AppColors.buttonYellow,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Next',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttonTextBlack,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: screenWidth * 0.04,
                      color: AppColors.buttonTextBlack,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Skip Button
          Positioned(
            top: screenHeight * 0.05,
            right: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                // Navigate to home screen
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.subheadlineTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}