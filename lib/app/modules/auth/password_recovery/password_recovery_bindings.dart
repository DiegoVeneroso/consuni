import 'package:get/get.dart';
import './password_recovery_controller.dart';

class PasswordRecoveryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PasswordRecoveryController(authRepositoryImpl: Get.find()));
  }
}
