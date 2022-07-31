import 'dart:convert';
import 'dart:developer';

import 'package:consuni_mobile/app/core/constants/constants.dart';
import 'package:consuni_mobile/app/core/exceptions/user_notfound_exception.dart';
import 'package:consuni_mobile/app/core/mixins/loader_mixin.dart';
import 'package:consuni_mobile/app/core/mixins/messages_mixin.dart';
import 'package:consuni_mobile/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PasswordRecoveryController extends GetxController
    with LoaderMixin, MessagesMixin {
  final AuthRepositoryImpl _authRepositoryImpl;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  PasswordRecoveryController({
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
        Get.toNamed('/auth/code_recovery', arguments: {"email": email});
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
