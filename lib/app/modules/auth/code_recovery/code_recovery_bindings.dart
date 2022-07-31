import 'package:get/get.dart';
import 'code_recovery_controller.dart';

class CodeRecoveryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(CodeRecoveryController(authRepositoryImpl: Get.find()));
  }
}
