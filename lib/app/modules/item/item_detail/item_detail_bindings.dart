import 'package:get/get.dart';
import './item_detail_controller.dart';

class ItemDetailBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ItemDetailController());
    }
}