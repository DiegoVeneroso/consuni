import 'dart:convert';
import 'dart:developer';

import 'package:consuni/app/core/constants/constants.dart';
import 'package:consuni/app/core/exceptions/user_notfound_exception.dart';
import 'package:consuni/app/core/mixins/loader_mixin.dart';
import 'package:consuni/app/core/mixins/messages_mixin.dart';
import 'package:consuni/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final AuthRepositoryImpl _authRepositoryImpl;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  LoginController({
    required AuthRepositoryImpl authRepositoryImpl,
  }) : _authRepositoryImpl = authRepositoryImpl;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      _loading.toggle();
      final userLoggedToken = await _authRepositoryImpl.login(email, password);
      final jsonToken = jsonDecode(userLoggedToken);

      final storage = GetStorage();
      await storage.write(Constants.USER_TOKEN, jsonToken['access_token']);
      _loading.toggle();
    } on UserNotFoundException catch (e, s) {
      _loading.toggle();
      log('Login ou senha inválidos', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Login ou senha inválidos',
        type: MessageType.error,
      ));
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao realizar login', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Erro ao realizar login',
        type: MessageType.error,
      ));
    }
  }
}
