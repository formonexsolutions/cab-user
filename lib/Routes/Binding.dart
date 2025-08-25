import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../Login/Logincontrollers/AuthController.dart';
import '../Login/Logincontrollers/LoginController.dart';
import '../controllers/HomeControllers/HomeController.dart';
import '../controllers/HomeControllers/search_controller.dart';

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