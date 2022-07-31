import 'package:consuni_mobile/app/repositories/item/item_repository.dart';
import 'package:consuni_mobile/app/repositories/item/item_repository_impl.dart';
import 'package:get/get.dart';
import './add_item_controller.dart';

class AddItemBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemRepositoryImpl(restClient: Get.find()));
    Get.put(AddItemController(ItemRepositoryImpl: Get.find()));
  }
}
