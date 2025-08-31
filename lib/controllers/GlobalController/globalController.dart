import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/Constants/storage_keys.dart';


class GlobalController extends GetxController {

  // Use an observable variable to store the token
  var token = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    token.value = box.read(StorageKeys.token) ?? '';
  }

  void loadToken() {
    token.value = box.read(StorageKeys.token) ?? '';
  }

  void saveToken(String newToken) {
    box.write('token', newToken);
    token.value = newToken;
  }

  void logout() {
    box.remove('token');
    token.value = '';
  }
}