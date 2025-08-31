import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../modules/Homepage/HomeMapScreen.dart';
import '../modules/Homepage/View/HomeScreen.dart';
import '../modules/Homepage/View/PaymentView.dart';
import '../modules/Homepage/View/RideCompletedView.dart';
import '../modules/Homepage/View/RideDetailsView.dart';
import '../modules/Homepage/View/SearchView.dart';
import '../modules/Homepage/View/trackDriver.dart';
import '../modules/Login/Views/AuthView.dart';
import '../modules/Login/Views/Login/LoginScreen.dart';
import '../modules/Login/Views/Login/otp_verification_page.dart';
import '../modules/Login/Views/Login/signup_page.dart';
import '../modules/Login/Views/Splash/SplashScreen1.dart';
import '../modules/Login/Views/Splash/SplashScreen2.dart';
import '../modules/Login/Views/Splash/SplashScreen3.dart';
import '../modules/Login/Views/Splash/WelcomePage.dart';
import '../modules/Login/Views/SplashScreen.dart';
import 'Binding.dart';



// A class to hold static route names for easy access.
abstract class AppRoutes {
  static const splashInitial = '/';
  static const splash = '/splash';
  static const splash2 = '/spalsh2';
  static const splash3 = '/splash3';
  static const welcome = '/welcome';
  static const login = '/Login';
  static const signup = '/signup';
  static const otpVerify = '/otpVerify';
  static const auth = '/auth';
  static const home = '/home';
  static const searchView = '/searchView';
  static const homeMap = '/homeMap';
  static const rideDetailsView = '/rideDetailsView';
  static const trackDriver = '/trackDriver';
  static const rideCompletedView = '/rideCompletedView';
  static const paymentView = '/paymentView';
}

// The list of all pages in the application with their bindings.
abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splashInitial,
      page: () =>   SplashScreen(),
      transition: Transition.rightToLeft, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen1(),
      transition: Transition.rightToLeft, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    ),
    GetPage(
      name: AppRoutes.splash2,
      page: () => const SplashScreen2(),
      transition: Transition.leftToRight, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    ),
    GetPage(
      name: AppRoutes.splash3,
      page: () => const SplashScreen3(),
      transition: Transition.downToUp, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
      transition: Transition.downToUp, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    ),

    GetPage(
      name: AppRoutes.login,
      page: () =>   LoginPage(),
      transition: Transition.downToUp, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () =>   SignupPage(),
      transition: Transition.downToUp, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.otpVerify,
      page: () =>   OtpVerificationPage(),
      transition: Transition.downToUp, // Right-to-left transition
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.auth,
      page: () =>   AuthView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
     ),

    GetPage(
      name: AppRoutes.homeMap,
      page: () => const MapScreen(),
     ),

    GetPage(
      name: AppRoutes.searchView,
      page: () => const SearchView(),
      binding: SearchViewBinding(),
     ),

    GetPage(
      name: AppRoutes.rideDetailsView,
      page: () => const RideDetailsView(),
      binding: RideDetailsBinding(),
     ),

    GetPage(
      name: AppRoutes.trackDriver,
      page: () =>   TrackDriver(),
      binding: RideDetailsBinding(),
     ),

    GetPage(
      name: AppRoutes.rideCompletedView,
      page: () =>   RideCompletedView(),
      binding: RideCompletedViewBinding(),
     ),
    GetPage(
      name: AppRoutes.paymentView,
      page: () =>   PaymentView(),
      binding: PaymentViewBinding(),
     ),
  ];
}
