import 'package:get/get.dart';

import '../Login/Views/AuthView.dart';
import '../Login/Views/SplashScreen.dart';
import '../View/Homepage/HomeScreen.dart';
import 'Binding.dart';



// A class to hold static route names for easy access.
abstract class AppRoutes {
  static const splash = '/';
  static const auth = '/auth';
  static const home = '/home';
}

// The list of all pages in the application with their bindings.
abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
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
  ];
}
