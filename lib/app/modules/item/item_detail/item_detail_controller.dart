import 'package:consuni_mobile/app/models/item_model.dart';
import 'package:get/get.dart';

class ItemDetailController extends GetxController {
  final _item = Rx<ItemModel>(Get.arguments);

  ItemModel get item => _item.value;
}
