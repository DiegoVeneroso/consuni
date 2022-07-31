import 'package:get/get.dart';
import './edit_item_controller.dart';

class EditItemBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(EditItemController(ItemRepositoryImpl: Get.find()));
  }
}
