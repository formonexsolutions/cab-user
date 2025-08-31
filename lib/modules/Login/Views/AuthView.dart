import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Logincontrollers/AuthController.dart';


class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Car Travel'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to your Car Travel App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sign in to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Email TextField
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.email, color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.lock, color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 32),

                // Email/Password Sign-in Button
                Obx(() => controller.isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.signInWithEmailAndPassword,
                  child: const Text(
                    'Sign In with Email',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 16),

                // Forgot Password Button
                TextButton(
                  onPressed: controller.resetPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(height: 16),

                // Divider or text for other sign-in options
                const Text(
                  'OR',
                  style: TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 16),

                // Google Sign-in Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.signInWithGoogle,
                  icon: Image.asset(
                    'assets/google_Logo.png',
                    height: 24,
                  ),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
