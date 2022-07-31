import 'package:consuni_mobile/app/modules/auth/login/login_controller.dart';
import 'package:consuni_mobile/app/repositories/auth/auth_repository.dart';
import 'package:consuni_mobile/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(restClient: Get.find()),
    );

    Get.lazyPut(
      () => LoginController(authRepositoryImpl: Get.find()),
    );
  }
}
