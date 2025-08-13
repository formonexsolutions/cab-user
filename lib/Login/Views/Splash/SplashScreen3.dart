import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/AppRoutes.dart';
import '../../../Utils/app_colors.dart';

class SplashScreen3 extends StatefulWidget {
  const SplashScreen3({Key? key}) : super(key: key);

  @override
  State<SplashScreen3> createState() => _SplashScreen3State();
}

class _SplashScreen3State extends State<SplashScreen3> {
  bool isLoading = false;

  void checkLoginStatus() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(AppRoutes.welcome);
    setState(() {
      isLoading = false;
    });
  }

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
              'assets/images/Png03.png',
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
                  'Your Journey, One Click Away',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headlineTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Tap. Ride. Arrive. It\'s that simple.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.subheadlineTextColor,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Indicators
          Positioned(
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.1,
            child: Row(
              children: [
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
                SizedBox(width: screenWidth * 0.02),
                Container(
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryYellow, // Active indicator
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(fontSize: screenWidth * 0.04, color: AppColors.buttonTextBlack),
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios, size: screenWidth * 0.04, color: AppColors.headlineTextColor),
            ),
          ),

          // Go Button
          Positioned(
            bottom: screenHeight * 0.05,
            right: screenWidth * 0.05,
            child: GestureDetector(
              onTap: isLoading ? null : () => checkLoginStatus(),
              child: Container(
                width: screenWidth * 0.18, // Circular button size
                height: screenWidth * 0.18,
                alignment: Alignment.center, // Center the content
                decoration: BoxDecoration(
                  color: isLoading ? AppColors.primaryYellow.withOpacity(0.5) : AppColors.primaryYellow,
                  shape: BoxShape.circle,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: AppColors.buttonTextBlack,
                )
                    : Text(
                  'Go',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonTextBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}