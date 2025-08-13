import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Routes/AppRoutes.dart';
import '../../../Utils/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions to make the UI responsive
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back button at the top left corner
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.headlineTextColor,
                      size: 24,
                    ),
                    onPressed: () {
                      // Handle back button press
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Image section
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/welcome.png', // Replace with your image path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Welcome text
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: AppColors.headlineTextColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Hello there! Let\'s get you moving',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.subheadlineTextColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.08),

              // Create an account button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.signup);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                  ),
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonTextBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Log-in button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.buttonOutline,
                    side: const BorderSide(
                        color: AppColors.buttonOutline, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                  ),
                  child: Text(
                    'Log-in',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonTextBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}