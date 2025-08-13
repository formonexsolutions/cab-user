import 'dart:async';
import 'package:get/get.dart';

class OtpController extends GetxController {
  RxInt timer = 60.obs;
  RxBool isResendButtonEnabled = false.obs;
  late Timer _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer.value = 60;
    isResendButtonEnabled.value = false;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        _countdownTimer.cancel();
        isResendButtonEnabled.value = true;
      }
    });
  }

  void resendCode() {
    startTimer();
  }

  @override
  void onClose() {
    _countdownTimer.cancel();
    super.onClose();
  }
}