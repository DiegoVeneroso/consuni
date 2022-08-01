import 'dart:developer';

import 'package:consuni/app/core/mixins/loader_mixin.dart';
import 'package:consuni/app/core/mixins/messages_mixin.dart';
import 'package:consuni/app/core/rest_client/rest_client.dart';
import 'package:consuni/app/models/view_models/register_view_model.dart';
import 'package:consuni/app/modules/auth/login/login_controller.dart';
import 'package:consuni/app/repositories/auth/auth_repository.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController
    with LoaderMixin, MessagesMixin {
  final AuthRepository _authRepository;
  final LoginController _loginController;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  var isItemPicPathSet = false.obs;
  var itemPicPath = "".obs;

  RegisterController({
    required AuthRepository authRepository,
    required LoginController loginController,
  })  : _authRepository = authRepository,
        _loginController = loginController;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> register(RegisterViewModel registerViewModel) async {
    try {
      _loading.toggle(); //abre o loading

      await _authRepository.register(registerViewModel);
      await _loginController.login(
        email: registerViewModel.email.toString(),
        password: registerViewModel.password.toString(),
      );

      _loading.toggle(); //fecha o loading

      Get.back();

      _message(MessageModel(
        title: 'Sucesso',
        message: 'Cadastro realizado com sucesso',
        type: MessageType.info,
      ));
    } on RestClientException catch (e, s) {
      _loading.toggle(); //fecha o loaging que foi aberto no try

      log('Erro ao registrar o usuario', error: e, stackTrace: s);

      _message(
        MessageModel(
          title: 'Erro',
          message: e.message,
          type: MessageType.error,
        ),
      );
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao registrar o usuario', error: e, stackTrace: s);

      _message(
        MessageModel(
          title: 'Erro',
          message: 'Erro ao registrar o usuario',
          type: MessageType.error,
        ),
      );
    }
  }

  void setItemImagePath(String path) {
    itemPicPath.value = path;
    isItemPicPathSet.value = true;
  }

  Future<List?> getInstituicao() async {
    try {
      return _authRepository.getInstituicao();
    } on RestClientException catch (e, s) {
      log('Erro ao buscar instituicao', error: e, stackTrace: s);
    } catch (e, s) {
      log('Erro ao buscar instituicao', error: e, stackTrace: s);
    }
    return null;
  }

  Future<List?> getClasse() async {
    try {
      return _authRepository.getClasse();
    } on RestClientException catch (e, s) {
      log('Erro ao buscar classe', error: e, stackTrace: s);
    } catch (e, s) {
      log('Erro ao buscar classe', error: e, stackTrace: s);
    }
    return null;
  }
}
