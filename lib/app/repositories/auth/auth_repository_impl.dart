import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:consuni_mobile/app/core/constants/constants.dart';
import 'package:consuni_mobile/app/core/exceptions/user_notfound_exception.dart';
import 'package:consuni_mobile/app/core/rest_client/rest_client.dart';
import 'package:consuni_mobile/app/core/services/auth_services.dart';
import 'package:consuni_mobile/app/models/userDrawer_model.dart';
import 'package:consuni_mobile/app/models/user_model.dart';
import 'package:consuni_mobile/app/models/view_models/register_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RestClient _restClient;
  final _getStorage = GetStorage();

  AuthRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  // Future<UserModel> register(String name, String email, String password) async {
  // Future<String> register(String name, String email, String password) async {
  Future<String> register(RegisterViewModel registerViewModel) async {
    final result = await _restClient.post('/auth/register', {
      'nome': registerViewModel.name,
      'email': registerViewModel.email,
      'celular': registerViewModel.celular,
      'password': registerViewModel.password,
      'instituicao': registerViewModel.instituicao,
      'classe': registerViewModel.classe,
      'cargo': registerViewModel.cargo,
      'funcao': registerViewModel.funcao,
      'representante': registerViewModel.representante,
      'tokenPush': registerViewModel.tokenPush,
      'imageAvatar': registerViewModel.imageAvatar,
    });

    if (result.hasError) {
      var message = 'Erro ao registrar usuário';
      if (result.statusCode == 400) {
        message = result.body['error'];
      }

      log(
        message,
        error: result.statusText,
        stackTrace: StackTrace.current,
      );

      throw RestClientException(message);
    }

    return login(registerViewModel.email.toString(),
        registerViewModel.password.toString());
  }

  @override
  Future<String> login(String email, String password) async {
    final result = await _restClient.post('/auth/', {
      'login': email,
      'password': password,
    });

    if (result.hasError) {
      if (result.statusCode == 403) {
        log(
          'usuario ou senha inválidos',
          error: result.statusText,
          stackTrace: StackTrace.current,
        );

        throw UserNotFoundException();
      }

      log(
        'Erro ao autenticar o usuário (${result.statusCode})',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao autenticar usuário');
    }

    return result.bodyString.toString();
  }

  @override
  Future<UserDrawerModel> getUserByToken() async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    final result = await _restClient.get(
      '/user/',
      headers: {
        'Authorization': userToken,
      },
    );

    if (result.hasError) {
      if (result.statusCode == 403) {
        AuthServices().logout();
      }

      log(
        'Erro ao buscar o usuario pelo token ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao buscar usuário pelo token');
    }
    UserDrawerModel userDrawer = UserDrawerModel(
      id: result.body['id'],
      name: result.body['name'],
      representante: false,
      imageAvatar: result.body['imageAvatar'],
    );
    return userDrawer;
  }

  @override
  Future<List?> getInstituicao() async {
    final result = await _restClient.get(
      '/user/instituicao',
    );
    if (result.hasError) {
      log(
        'Erro ao buscar a instituicao: ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao buscar a instituicao');
    }

    Map valueMap = jsonDecode(result.bodyString.toString());
    return valueMap['instituicoes'];
  }

  @override
  Future<List?> getClasse() async {
    final result = await _restClient.get(
      '/user/classe',
    );
    if (result.hasError) {
      log(
        'Erro ao buscar a classe: ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao buscar a classe');
    }

    Map valueMap = jsonDecode(result.bodyString.toString());
    return valueMap['classes'];
  }

  @override
  Future<String> recoveryPassword(String email) async {
    final result =
        await _restClient.post('/auth/recovery_password/email?email=$email', {
      'email': email,
    });

    if (result.hasError) {
      log(
        'E-mail não cadastrado: $email',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
    }

    return result.bodyString.toString();
  }

  @override
  Future<String> validadeCode(String email, int code) async {
    final result = await _restClient.post(
        '/auth/confirm_code/code?email=$email&code=$code',
        {'email': email, 'code': code});

    if (result.hasError) {
      log(
        'Erro ao validar o código: $email',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
    }

    return result.body['Message'];
  }
}
