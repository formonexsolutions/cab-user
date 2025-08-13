import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Routes/AppRoutes.dart';
import '../../../Utils/app_colors.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Title
                Text(
                  'Let\'s get you moving',
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryYellow,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Subtitle
                Text(
                  'Enter your mobile number to start\nyour ride',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: AppColors.subheadlineTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Full Name input field
                _buildTextField(
                  screenWidth,
                  screenHeight,
                  hintText: 'Enter your full name',
                  icon: Icons.person_outline,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Email Address input field
                _buildTextField(
                  screenWidth,
                  screenHeight,
                  hintText: 'Enter your email address',
                  icon: Icons.mail_outline,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Phone Number input field
                _buildTextField(
                  screenWidth,
                  screenHeight,
                  hintText: 'Enter your phone number',
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Password input field
                _buildTextField(
                  screenWidth,
                  screenHeight,
                  hintText: 'Create password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                SizedBox(height: screenHeight * 0.05),

                // Send OTP button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.otpVerify);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                    ),
                    child: Text(
                      'Send OTP',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttonTextBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // OR divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.dividerColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: AppColors.subheadlineTextColor,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.dividerColor)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Sign up with
                Center(
                  child: Text(
                    'Sign up with',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppColors.subheadlineTextColor,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Social media buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                        screenWidth, 'assets/images/google_Logo.png', () {
                      // Handle Google signup
                    }),
                    SizedBox(width: screenWidth * 0.05),
                    _buildSocialButton(
                        screenWidth, 'assets/images/facebook.png', () {
                      // Handle Facebook signup
                    }),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // "Already have an account?" text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: AppColors.subheadlineTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login page
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(
                        'Log-in',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: AppColors.linkTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      double screenWidth,
      double screenHeight, {
        required String hintText,
        required IconData icon,
        bool isPassword = false,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hintTextColor),
        prefixIcon: Icon(
          icon,
          color: AppColors.iconColor,
        ),
        filled: true,
        fillColor: AppColors.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.04),
      ),
    );
  }

  Widget _buildSocialButton(
      double screenWidth,
      String imagePath,
      VoidCallback onPressed,
      ) {
    return SizedBox(
      width: screenWidth * 0.15,
      height: screenWidth * 0.15,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(color: AppColors.dividerColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
        ),
        child: Image.asset(imagePath, height: screenWidth * 0.08),
      ),
    );
  }
}