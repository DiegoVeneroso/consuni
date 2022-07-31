import 'package:consuni_mobile/app/core/services/auth_services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Get.putAsync(() => AuthServices().init());
    super.onInit();
  }
}
