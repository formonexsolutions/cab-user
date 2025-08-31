import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Logincontrollers/LoginController.dart';

class SplashScreen extends StatelessWidget {
    SplashScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    controller.checkAuthentication();
    // if (FirebaseAuth.instance.currentUser != null) {
    //   Get.offAllNamed(AppRoutes.home);
    // } else {
    //   Get.offAllNamed(AppRoutes.auth);
    // }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_car,
              size: 100,
              color: Colors.yellow, // Ola-Uber जैसा रंग
            ),
            const SizedBox(height: 24),
            const Text(
              'Car Travel',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}