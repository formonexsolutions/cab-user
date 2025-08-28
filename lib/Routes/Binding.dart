import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../Login/Logincontrollers/AuthController.dart';
import '../Login/Logincontrollers/LoginController.dart';
import '../controllers/HomeControllers/HomeController.dart';
import '../controllers/HomeControllers/search_controller.dart';
import '../controllers/PaymentController.dart';
import '../controllers/RideCompletedController.dart';
import '../controllers/RideControllers/all_rides_controller.dart';
import '../controllers/RideDetailsController.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class SearchViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceSearchController>(() => PlaceSearchController());
  }
}

class RideDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideDetailsController>(() => RideDetailsController());
  }
}

class RideCompletedViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideCompletedController>(() => RideCompletedController());
  }
}

class PaymentViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}

class AllRidesPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllRidesController>(() => AllRidesController());
  }
}