// import 'package:car_travel/Routes/AppRoutes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../Utils/app_colors.dart';
// import '../../Logincontrollers/LoginController.dart';
//
// class OtpVerificationPage extends StatefulWidget {
//   const OtpVerificationPage({super.key});
//
//   @override
//   _OtpVerificationPageState createState() => _OtpVerificationPageState();
// }
//
// class _OtpVerificationPageState extends State<OtpVerificationPage> {
//   final LoginController controller = Get.put(LoginController());
//
//   final _otp1Controller = TextEditingController();
//   final _otp2Controller = TextEditingController();
//   final _otp3Controller = TextEditingController();
//   final _otp4Controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             // Use LayoutBuilder to get constraints, making the UI more flexible.
//             return SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: constraints.maxWidth * 0.08,
//                 vertical: constraints.maxHeight * 0.05,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   Text(
//                     'Verify & Go',
//                     style: TextStyle(
//                       fontSize: constraints.maxWidth * 0.07,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primaryYellow,
//                     ),
//                   ),
//                   SizedBox(height: constraints.maxHeight * 0.01),
//
//                   // Subtitle
//                   Text(
//                     'We\'ve sent a secure code to your\nnumber — enter it to continue',
//                     style: TextStyle(
//                       fontSize: constraints.maxWidth * 0.045,
//                       color: AppColors.subheadlineTextColor,
//                     ),
//                   ),
//                   SizedBox(height: constraints.maxHeight * 0.08),
//
//                   // OTP Input Fields
//                   Form(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildOtpInput(context, constraints.maxWidth, _otp1Controller, true),
//                         _buildOtpInput(context, constraints.maxWidth, _otp2Controller, false),
//                         _buildOtpInput(context, constraints.maxWidth, _otp3Controller, false),
//                         _buildOtpInput(context, constraints.maxWidth, _otp4Controller, false, last: true),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: constraints.maxHeight * 0.04),
//
//                   // Timer and Resend Code
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Obx(() => Text(
//                         '00 : ${controller.timer.value.toString().padLeft(2, '0')}',
//                         style: TextStyle(
//                           fontSize: constraints.maxWidth * 0.04,
//                           color: AppColors.subheadlineTextColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )),
//                       Obx(() => TextButton(
//                         onPressed: controller.isResendButtonEnabled.value
//                             ? () {
//                           controller.resendCode();
//                         }
//                             : null,
//                         child: Text(
//                           'Resend Code',
//                           style: TextStyle(
//                             fontSize: constraints.maxWidth * 0.04,
//                             color: controller.isResendButtonEnabled.value
//                                 ? AppColors.linkTextColor
//                                 : AppColors.subheadlineTextColor,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       )),
//                     ],
//                   ),
//                   SizedBox(height: constraints.maxHeight * 0.04), // Fixed spacing
//
//                   // Verify button
//                   SizedBox(
//                     width: double.infinity,
//                     height: constraints.maxHeight * 0.07,
//                     child: ElevatedButton(
//                       onPressed: () {
//
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.buttonYellow,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
//                         ),
//                       ),
//                       child: Text(
//                         'Verify',
//                         style: TextStyle(
//                           fontSize: constraints.maxWidth * 0.045,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.buttonTextBlack,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: constraints.maxHeight * 0.02), // Fixed spacing
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOtpInput(
//       BuildContext context,
//       double parentWidth,
//       TextEditingController textController,
//       bool autoFocus,
//       {bool last = false}) {
//     return SizedBox(
//       width: parentWidth * 0.18,
//       height: parentWidth * 0.18,
//       child: TextFormField(
//         autofocus: autoFocus,
//         controller: textController,
//         onChanged: (value) {
//           setState(() {});
//           if (value.length == 1 && !last) {
//             FocusScope.of(context).nextFocus();
//           }
//           if (value.isEmpty && !autoFocus) {
//             FocusScope.of(context).previousFocus();
//           }
//         },
//         style: TextStyle(
//           fontSize: parentWidth * 0.06,
//           fontWeight: FontWeight.bold,
//           color: textController.text.isNotEmpty ? AppColors.primaryWhite : AppColors.buttonTextBlack,
//         ),
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: textController.text.isNotEmpty ? AppColors.primaryYellow : AppColors.textFieldBackground,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(parentWidth * 0.03),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: EdgeInsets.zero,
//         ),
//       ),
//     );
//   }
// }

import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../../Logincontrollers/LoginController.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final LoginController controller = Get.put(LoginController());

  // Changed to 6 controllers for a 6-digit OTP
  final _otp1Controller = TextEditingController();
  final _otp2Controller = TextEditingController();
  final _otp3Controller = TextEditingController();
  final _otp4Controller = TextEditingController();
  final _otp5Controller = TextEditingController();
  final _otp6Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.08,
                vertical: constraints.maxHeight * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify & Go',
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryYellow,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Text(
                    'We\'ve sent a secure code to your\nnumber — enter it to continue',
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.045,
                      color: AppColors.subheadlineTextColor,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.08),

                  // Updated for 6-digit OTP input
                  Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOtpInput(context, constraints.maxWidth, _otp1Controller, true),
                        _buildOtpInput(context, constraints.maxWidth, _otp2Controller, false),
                        _buildOtpInput(context, constraints.maxWidth, _otp3Controller, false),
                        _buildOtpInput(context, constraints.maxWidth, _otp4Controller, false),
                        _buildOtpInput(context, constraints.maxWidth, _otp5Controller, false),
                        _buildOtpInput(context, constraints.maxWidth, _otp6Controller, false, last: true),
                      ],
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),

                  // Timer and Resend Code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                        '00 : ${controller.timer.value.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.04,
                          color: AppColors.subheadlineTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Obx(() => TextButton(
                        onPressed: controller.isResendButtonEnabled.value
                            ? () {
                          controller.resendCode();
                        }
                            : null,
                        child: Text(
                          'Resend Code',
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.04,
                            color: controller.isResendButtonEnabled.value
                                ? AppColors.linkTextColor
                                : AppColors.subheadlineTextColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),

                  // Updated Verify button with API call logic
                  SizedBox(
                    width: double.infinity,
                    height: constraints.maxHeight * 0.07,
                    child: Obx(
                          () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                          // Combine all 6 OTP inputs into a single string
                          String otp = _otp1Controller.text +
                              _otp2Controller.text +
                              _otp3Controller.text +
                              _otp4Controller.text +
                              _otp5Controller.text +
                              _otp6Controller.text;

                          // Set the combined OTP to the controller
                          controller.otpController.text = otp;

                          // Call the verifyOtp function from the controller
                          controller.verifyOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                          color: AppColors.buttonTextBlack,
                        )
                            : Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.buttonTextBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // _buildOtpInput function (unchanged)
  Widget _buildOtpInput(
      BuildContext context,
      double parentWidth,
      TextEditingController textController,
      bool autoFocus,
      {bool last = false}) {
    return SizedBox(
      width: parentWidth * 0.14, // Adjusted width for 6 digits
      height: parentWidth * 0.14, // Adjusted height
      child: TextFormField(
        autofocus: autoFocus,
        controller: textController,
        onChanged: (value) {
          setState(() {});
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !autoFocus) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: TextStyle(
          fontSize: parentWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: textController.text.isNotEmpty ? AppColors.primaryWhite : AppColors.buttonTextBlack,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: textController.text.isNotEmpty ? AppColors.primaryYellow : AppColors.textFieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(parentWidth * 0.03),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}