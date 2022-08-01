import 'dart:developer';

import 'package:consuni/app/core/mixins/loader_mixin.dart';
import 'package:consuni/app/core/mixins/messages_mixin.dart';
import 'package:consuni/app/core/rest_client/rest_client.dart';
import 'package:consuni/app/models/item_model.dart';
import 'package:consuni/app/modules/home/home_controller.dart';
import 'package:consuni/app/repositories/item/item_repository_impl.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController with LoaderMixin, MessagesMixin {
  final ItemRepositoryImpl _itemRepositoryImpl;
  HomeController homeController =
      HomeController(itemRepositoryImpl: Get.find());

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  var isItemPicPathSet = false.obs;
  var itemPicPath = "".obs;

  AddItemController({
    required ItemRepositoryImpl ItemRepositoryImpl,
  }) : _itemRepositoryImpl = ItemRepositoryImpl;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  void setItemImagePath(String path) {
    itemPicPath.value = path;
    isItemPicPathSet.value = true;
  }

  Future<void> addItem(ItemModel item) async {
    try {
      _loading.toggle(); //abre o loading

      await _itemRepositoryImpl.addItem(item);

      _loading.toggle(); //fecha o loading

      _message(MessageModel(
        title: 'Sucesso',
        message: 'Cadastro realizado com sucesso',
        type: MessageType.info,
      ));

      await Get.offAndToNamed('/home');
    } on RestClientException catch (e, s) {
      _loading.toggle(); //fecha o loaging que foi aberto no try

      log('Erro ao registrar o item', error: e, stackTrace: s);

      _message(
        MessageModel(
          title: 'Erro',
          message: e.message,
          type: MessageType.error,
        ),
      );
    } catch (e, s) {
      _loading.toggle(); //fecha o loading
      log('Erro ao registrar o usuario', error: e, stackTrace: s);

      _message(
        MessageModel(
          title: 'Erro',
          message: 'Erro ao registrar o item',
          type: MessageType.error,
        ),
      );
    }
  }
}
