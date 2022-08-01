import 'package:consuni/app/core/rest_client/rest_client.dart';
import 'package:get/get.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RestClient(),
      fenix: true,
    );
  }
}
