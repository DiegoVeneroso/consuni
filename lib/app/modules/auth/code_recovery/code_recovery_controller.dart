import 'dart:developer';

import 'package:consuni_mobile/app/core/mixins/loader_mixin.dart';
import 'package:consuni_mobile/app/core/mixins/messages_mixin.dart';
import 'package:consuni_mobile/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';

class CodeRecoveryController extends GetxController
    with LoaderMixin, MessagesMixin {
  final AuthRepositoryImpl _authRepositoryImpl;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  CodeRecoveryController({
    required AuthRepositoryImpl authRepositoryImpl,
  }) : _authRepositoryImpl = authRepositoryImpl;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> validadeCode({required String email, required int code}) async {
    try {
      _loading.toggle();
      final result = await _authRepositoryImpl.validadeCode(email, code);

      if (result == 'Internal Server Error' || result == 'Código inválido') {
        _loading.toggle();
        _message(MessageModel(
          title: 'Erro',
          message: 'Código inválido!',
          type: MessageType.error,
        ));
      } else {
        _loading.toggle();
        _message(MessageModel(
          title: 'Sucesso',
          message: 'Código válido, cadastre nova senha!',
          type: MessageType.info,
        ));
        Get.toNamed('/auth/password_renew');
      }
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao validar o código', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Erro ao validar o código',
        type: MessageType.error,
      ));
    }
  }
}
