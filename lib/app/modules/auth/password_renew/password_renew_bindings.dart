import 'package:consuni/app/modules/auth/password_renew/password_renew_controller.dart';
import 'package:get/get.dart';

class PasswordRenewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PasswordRenewController(authRepositoryImpl: Get.find()));
  }
}
