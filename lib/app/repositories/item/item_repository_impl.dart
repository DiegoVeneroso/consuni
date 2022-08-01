import 'dart:developer';
import 'package:consuni/app/core/constants/constants.dart';
import 'package:consuni/app/core/rest_client/rest_client.dart';
import 'package:consuni/app/core/services/auth_services.dart';
import 'package:consuni/app/models/item_model.dart';
import 'package:consuni/app/models/userDrawer_model.dart';
import 'package:get_storage/get_storage.dart';
import './item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final RestClient _restClient;
  final _getStorage = GetStorage();

  ItemRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<List<ItemModel>> findAll(String text) async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    if (text == '') {
      final result = await _restClient.get(
        '/items/',
        headers: {
          'Authorization': userToken,
        },
      );
    }

    final result = await _restClient.get(
      '/items/$text',
      headers: {
        'Authorization': userToken,
      },
    );

    if (result.hasError) {
      if (result.statusCode == 403) {
        AuthServices().logout();
      }

      log(
        'Erro ao buscar o item principal ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao buscar os items');
    }
    return result.body.map<ItemModel>((p) => ItemModel.fromMap(p)).toList();
  }

  @override
  Future<void> addItem(ItemModel item) async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    final result = await _restClient.post('/items/', {
      "title": item.title,
      "subtitle": item.subtitle,
      "description": item.description,
      "image": item.image
    }, headers: {
      'Authorization': userToken,
    });

    if (result.hasError) {
      var message = 'Erro ao registrar item';
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
  }

  @override
  Future<void> deleteItem(int idItem) async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    final result = await _restClient.delete(
      '/items/$idItem',
      headers: {
        'Authorization': userToken,
      },
    );

    if (result.hasError) {
      var message = 'Erro ao deletar item';
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
  }

  @override
  Future<void> updateItem(ItemModel item) async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    final result = await _restClient.put(
      '/items/${item.id}',
      {
        "id": item.id,
        "title": item.title,
        "subtitle": item.subtitle,
        "description": item.description,
        "image": item.image
      },
      headers: {
        'Authorization': userToken,
        // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTUzMTQ5MjEsImlhdCI6MTY1NTIyODUyMSwiaXNzIjoiY3VpZGFwZXQiLCJuYmYiOjE2NTUyMjg1MjEsInN1YiI6IjEwOSIsInN1cHBsaWVyIjpudWxsfQ.4EsX5U3lUFvLhlahWsLRvSwnLclTVuA-RO1we21QcCA',
      },
    );

    if (result.hasError) {
      var message = 'Erro ao atualizar item';
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
  }

  @override
  Future<void> searchItem(String text) async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    final result = await _restClient.get(
      '/items/$text',
      headers: {
        'Authorization': userToken,
      },
    );

    if (result.hasError) {
      log(
        'Erro ao buscar o item principal ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao buscar os items principais');
    }
    return result.body.map<ItemModel>((p) => ItemModel.fromMap(p)).toList();
  }

  @override
  Future<UserDrawerModel> getUserDrawer() async {
    final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    final result = await _restClient.get(
      '/user/',
      headers: {
        'Authorization': userToken,
      },
    );

    if (result.hasError) {
      log(
        'Erro ao buscar o item principal ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao buscar os items principais');
    }
    return result.body
        .map<UserDrawerModel>((p) => UserDrawerModel.fromMap(p))
        .toList();
  }
}
