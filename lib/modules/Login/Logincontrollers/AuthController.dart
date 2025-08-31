import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Routes/AppRoutes.dart';
import '../../../data/Services/Firestore_Service_Class.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _firestoreService = FirestoreService();

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  Future<void> _addOrUpdateUserToFirestore(User user) async {
    final newUserModel = UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      role: 'rider', // Default role 'rider' set karein.
      createdAt: Timestamp.now(),
    );
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

      // Successfully sign-in - Firestore add
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

      // Successfully sign-in  Firestore add
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