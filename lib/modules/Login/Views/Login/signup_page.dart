import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../Routes/AppRoutes.dart';
import '../../../../core/Utils/app_colors.dart';
import '../../Logincontrollers/LoginController.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();

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
                  controller: controller.fullNameController,
                  screenWidth,
                  screenHeight,
                  hintText: 'Enter your full name',
                  icon: Icons.person_outline,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Email Address input field
                _buildTextField(
                  controller: controller.emailController,
                  screenWidth,
                  screenHeight,
                  hintText: 'Enter your email address',
                  icon: Icons.mail_outline,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Phone Number input field with country code picker
                IntlPhoneField(
                  initialCountryCode: 'IN', // Default country code India hai.
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    hintStyle: const TextStyle(color: AppColors.hintTextColor),
                    filled: true,
                    fillColor: AppColors.textFieldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.04,
                    ),
                  ),
                  onChanged: (phone) {
                    controller.phoneController.text = phone.completeNumber;
                  },
                  keyboardType: TextInputType.phone,
                ),
                // SizedBox(height: screenHeight * 0.02),
                //
                // // Password input field
                // _buildTextField(
                //   controller: controller.passwordController,
                //   screenWidth,
                //   screenHeight,
                //   hintText: 'Create password',
                //   icon: Icons.lock_outline,
                //   isPassword: true,
                // ),
                SizedBox(height: screenHeight * 0.05),

                // Send OTP button
                buildSignUpButton(screenWidth, screenHeight),

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
        TextEditingController? controller, // Optional controller
      }) {
    return TextFormField(
      controller: controller, // Use the optional controller
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintTextColor),
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


Widget buildSignUpButton(double screenWidth, double screenHeight) {
  final LoginController controller = Get.find<LoginController>();

  return SizedBox(
    width: double.infinity,
    height: screenHeight * 0.07,
    child: Obx(
          () => ElevatedButton(
        onPressed: controller.isLoading.value
            ? null // If loading, the button is disabled.
            : () {
          // --- Validation Logic ---
          if (controller.fullNameController.text.isEmpty ||
              controller.phoneController.text.isEmpty) {
            // Show an error message if fields are empty
            Get.snackbar(
              'Error',
              'Please fill in your name and mobile number.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            // If validation passes, proceed with the API call
            controller.signUp();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(
          color: AppColors.buttonTextBlack,
        ) // Show a loading indicator
            : Text(
          'Send OTP',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonTextBlack,
          ),
        ),
      ),
    ),
  );
}