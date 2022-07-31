import 'package:consuni_mobile/app/models/item_model.dart';
import 'package:consuni_mobile/app/models/userDrawer_model.dart';

abstract class ItemRepository {
  Future<List<ItemModel>> findAll(String text);
  Future<void> addItem(ItemModel item);
  Future<void> deleteItem(int idItem);
  Future<void> updateItem(ItemModel item);
  Future<void> searchItem(String text);
  Future<UserDrawerModel> getUserDrawer();
}
