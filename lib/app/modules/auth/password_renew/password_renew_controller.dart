import 'dart:developer';

import 'package:consuni/app/core/mixins/loader_mixin.dart';
import 'package:consuni/app/core/mixins/messages_mixin.dart';
import 'package:consuni/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';

class PasswordRenewController extends GetxController
    with LoaderMixin, MessagesMixin {
  final AuthRepositoryImpl _authRepositoryImpl;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  PasswordRenewController({
    required AuthRepositoryImpl authRepositoryImpl,
  }) : _authRepositoryImpl = authRepositoryImpl;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> recoveryPassword({required String email}) async {
    try {
      _loading.toggle();
      final result = await _authRepositoryImpl.recoveryPassword(email);

      if (result == 'Internal Server Error') {
        _loading.toggle();
        _message(MessageModel(
          title: 'Erro',
          message: 'E-mail não cadastrado!',
          type: MessageType.error,
        ));
      } else {
        _loading.toggle();
        _message(MessageModel(
          title: 'Sucesso',
          message: 'Código enviado para o e-mail informado!',
          type: MessageType.info,
        ));
        Get.toNamed('/auth/code_recovery');
      }
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao recuperar senha', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Erro ao recuperar senha',
        type: MessageType.error,
      ));
    }
  }
}
