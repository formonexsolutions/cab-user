// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../../Routes/AppRoutes.dart';
//
// class LoginController extends GetxController {
//   // Firebase Auth instance
//   final _auth = FirebaseAuth.instance;
//   // Google Sign-In instance. This is the correct way.
//   final _googleSignIn = GoogleSignIn();
//
//   // Logincontrollers for Email and Password TextFields
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   // Reactive variable to show/hide loading indicator
//   final RxBool _isLoading = RxBool(false);
//   bool get isLoading => _isLoading.value;
//
//   // --- Email/Password Sign-In ---
//   Future<void> signInWithEmailAndPassword() async {
//     _isLoading.value = true;
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       Get.snackbar('Success', 'Login successful!');
//       // TODO: Navigate to Home Screen
//       Get.toNamed(AppRoutes.home);
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = 'Sign-in failed. Please check your credentials.';
//       if (e.code == 'user-not-found') {
//         errorMessage = 'No user found for that email.';
//       } else if (e.code == 'wrong-password') {
//         errorMessage = 'Wrong password provided for that user.';
//       } else if (e.code == 'invalid-email') {
//         errorMessage = 'The email address is not valid.';
//       }
//       Get.snackbar('Error', errorMessage);
//     } finally {
//       _isLoading.value = false;
//     }
//   }
//
//   // --- Google Sign-In ---
//   Future<void> signInWithGoogle() async {
//     _isLoading.value = true;
//     try {
//       // Begin the Google sign-in process
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         // The user canceled the sign-in
//         _isLoading.value = false;
//         return;
//       }
//
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in to Firebase with the Google credential
//       await _auth.signInWithCredential(credential);
//       Get.snackbar('Success', 'Google Sign-in successful!');
//       // TODO: Navigate to Home Screen
//       Get.toNamed(AppRoutes.home);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar('Error', e.message ?? 'Google Sign-in failed.');
//     } finally {
//       _isLoading.value = false;
//     }
//   }
//
//   // --- Password Reset ---
//   Future<void> resetPassword() async {
//     if (emailController.text.isEmpty) {
//       Get.snackbar('Error', 'Please enter your email to reset the password.');
//       return;
//     }
//     try {
//       await _auth.sendPasswordResetEmail(email: emailController.text.trim());
//       Get.snackbar('Success', 'Password reset email sent to your email address.');
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar('Error', e.message ?? 'Failed to send password reset email.');
//     }
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }

// lib/Login/controllers/LoginController.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Routes/AppRoutes.dart';
import '../../Services/Firestore_Service_Class.dart';

class LoginController extends GetxController {
  // Firebase Auth instance
  final _auth = FirebaseAuth.instance;
  // Google Sign-In instance. This is the correct way.
  final _googleSignIn = GoogleSignIn();

  // Logincontrollers for Email and Password TextFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // FirestoreService ka instance banayein
  final _firestoreService = FirestoreService();

  // Reactive variable to show/hide loading indicator
  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  /// User ki details ko Firestore mein add ya update karta hai.
  Future<void> _addOrUpdateUserToFirestore(User user) async {
    final newUserModel = UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      role: 'rider', // Default role 'rider' set karein.
      createdAt: Timestamp.now(),
    );
    // Firestore mein user ko add karein, SetOptions(merge: true) se overwrite nahi hoga
    await _firestoreService.createUser(user: newUserModel);
  }

  // --- Email/Password Sign-In ---
  Future<void> signInWithEmailAndPassword() async {
    _isLoading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Successfully sign-in hone par Firestore mein user add karein
      if (userCredential.user != null) {
        await _addOrUpdateUserToFirestore(userCredential.user!);
      }

      Get.snackbar('Success', 'Login successful!');
      Get.toNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign-in failed. Please check your credentials.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      Get.snackbar('Error', errorMessage);
    } finally {
      _isLoading.value = false;
    }
  }

  // --- Google Sign-In ---
  Future<void> signInWithGoogle() async {
    _isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // Successfully sign-in hone par Firestore mein user add karein
      if (userCredential.user != null) {
        await _addOrUpdateUserToFirestore(userCredential.user!);
      }

      Get.snackbar('Success', 'Google Sign-in successful!');
      Get.toNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Google Sign-in failed.');
    } finally {
      _isLoading.value = false;
    }
  }

  // --- Password Reset ---
  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email to reset the password.');
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      Get.snackbar('Success', 'Password reset email sent to your email address.');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Failed to send password reset email.');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}