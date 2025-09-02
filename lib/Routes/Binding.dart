import 'package:get/get.dart';
import '../modules/Homepage/Controller/PaymentController.dart';
import '../modules/Homepage/Controller/RideCompletedController.dart';
import '../modules/Homepage/Controller/RideDetailsController.dart';
import '../modules/Homepage/Controller/HomeController.dart';
import '../modules/Homepage/Controller/search_controller.dart';
import '../modules/Login/Logincontrollers/AuthController.dart';
import '../modules/Login/Logincontrollers/LoginController.dart';

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