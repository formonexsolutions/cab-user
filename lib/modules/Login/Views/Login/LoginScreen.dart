import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../Routes/AppRoutes.dart';
import '../../../../Utils/app_colors.dart';
import '../../Logincontrollers/LoginController.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller ko yaha initialize karein
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
                  'Enter your mobile number or email\nto start your ride',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: AppColors.subheadlineTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Toggle for Email or Phone Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => controller.isEmailMode.value = true,
                      child: Obx(() => Text(
                        'Email',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: controller.isEmailMode.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: controller.isEmailMode.value
                              ? AppColors.primaryYellow
                              : AppColors.subheadlineTextColor,
                        ),
                      )),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                        color: AppColors.subheadlineTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.isEmailMode.value = false,
                      child: Obx(() => Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: !controller.isEmailMode.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: !controller.isEmailMode.value
                              ? AppColors.primaryYellow
                              : AppColors.subheadlineTextColor,
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.001),

                // Email or phone number input field based on toggle state
                Obx(() => controller.isEmailMode.value
                    ? _buildEmailField(screenWidth, screenHeight, controller.emailController)
                    : _buildPhoneField(screenWidth, screenHeight, controller.phoneController)),

                SizedBox(height: screenHeight * 0.03),

                // Password input field and forget password button
                // Ye poora section Obx ke andar hai
                Obx(() => controller.isEmailMode.value
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headlineTextColor,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Your password',
                        hintStyle: TextStyle(color: AppColors.hintTextColor),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
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
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    // Forget password button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: Text(
                          'Forget password',
                          style: TextStyle(
                            color: AppColors.subheadlineTextColor,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                )
                    : Container()), // Agar phone number mode hai, to empty container return karo

                // Log-in button
                buildLoginButton(screenWidth,screenHeight),
                // SizedBox(
                //   width: double.infinity,
                //   height: screenHeight * 0.07,
                //   child: ElevatedButton(
                //     onPressed: () {
                //      },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.buttonYellow,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(screenWidth * 0.04),
                //       ),
                //     ),
                //     child: Text(
                //       'Log -in',
                //       style: TextStyle(
                //         fontSize: screenWidth * 0.045,
                //         fontWeight: FontWeight.bold,
                //         color: AppColors.buttonTextBlack,
                //       ),
                //     ),
                //   ),
                // ),
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
                SizedBox(height: screenHeight * 0.04),

                // Sign in with text
                Center(
                  child: Text(
                    'Sign in with',
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
                    _buildSocialButton(screenWidth, 'assets/images/google_Logo.png', () {
                      // Handle Google sign-in
                    }),
                    SizedBox(width: screenWidth * 0.05),
                    _buildSocialButton(screenWidth, 'assets/images/facebook.png', () {
                      // Handle Facebook sign-in
                    }),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),

                // "Don't have an account?" text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: AppColors.subheadlineTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup); // Corrected navigation
                      },
                      child: Text(
                        'signup',
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

  // Separate widget for email field
  Widget _buildEmailField(double screenWidth, double screenHeight, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Enter Your mail id',
        hintStyle: TextStyle(color: AppColors.hintTextColor),
        prefixIcon: const Icon(
          Icons.mail_outline,
          color: AppColors.iconColor,
        ),
        filled: true,
        fillColor: AppColors.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
      ),
    );
  }

  // Separate widget for phone number field with country code picker
  Widget _buildPhoneField(double screenWidth, double screenHeight, TextEditingController controller) {
    return  IntlPhoneField(
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
        controller.text = phone.completeNumber;
      },
      keyboardType: TextInputType.phone,
    );
  }

  // Social button widget
  Widget _buildSocialButton(double screenWidth, String imagePath, VoidCallback onPressed) {
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

Widget buildLoginButton(double screenWidth, double screenHeight) {
  final LoginController controller = Get.find<LoginController>();

  return SizedBox(
    width: double.infinity,
    height: screenHeight * 0.07,
    child: Obx(
          () => ElevatedButton(
        onPressed: controller.isLoading.value
            ? null // If loading, disable the button
            : () {
          // Call the login function from your controller
          controller.login();
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
        ) // Show a loader when the API is called
            : Text(
          'Log -in',
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