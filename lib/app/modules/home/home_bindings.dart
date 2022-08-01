import 'package:consuni/app/modules/home/home_controller.dart';
import 'package:consuni/app/repositories/item/item_repository_impl.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemRepositoryImpl(restClient: Get.find()));
    Get.put(HomeController(itemRepositoryImpl: Get.find()));
  }
}
