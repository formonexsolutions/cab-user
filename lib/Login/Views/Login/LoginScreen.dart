import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Routes/AppRoutes.dart';
import '../../../Utils/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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

                // Email or phone number input field
                Text(
                  'Email or phone number',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headlineTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
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
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.04),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Password input field
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

                // Forget password button moved here
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

                // Log-in button
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
                      'Log -in',
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
                    SizedBox(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Google sign-in
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: const BorderSide(color: AppColors.dividerColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          ),
                        ),
                        child: Image.asset('assets/images/google_Logo.png', height: screenWidth * 0.08),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    SizedBox(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Facebook sign-in
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: const BorderSide(color: AppColors.dividerColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          ),
                        ),
                        child: Image.asset('assets/images/facebook.png', height: screenWidth * 0.08),
                      ),
                    ),
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
                        // Handle signup navigation
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
}