import 'dart:developer';

import 'package:consuni/app/core/rest_client/rest_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:consuni/app/core/constants/constants.dart';

class AuthServices extends GetxService {
  final _isLogged = RxnBool();
  final _getStorage = GetStorage();
  final _restClient = RestClient();

  Future<AuthServices> init() async {
    await Future.delayed(const Duration(seconds: 2));

    // if (_getStorage.read(Constants.USER_TOKEN) != null) {
    //   final String userToken = await _getStorage.read(Constants.USER_TOKEN);
    //   final result = await _restClient.get(
    //     '/items/',
    //     headers: {
    //       'Authorization': userToken,
    //     },
    //   );

    //   if (result.statusCode == 403) {
    //     log(
    //       'access token expirado ${result.statusCode}',
    //       error: result.statusText,
    //       stackTrace: StackTrace.current,
    //     );
    //     _getStorage.write(Constants.USER_TOKEN, null);
    //   }
    // }

    _getStorage.listenKey(Constants.USER_TOKEN, (value) async {
      if (value != null) {
        _isLogged(true);
        final String userToken = await _getStorage.read(Constants.USER_TOKEN);
        final result = await _restClient.get(
          '/items/',
          headers: {
            'Authorization': userToken,
          },
        );

        if (result.statusCode == 403) {
          log(
            'access token expirado ${result.statusCode}',
            error: result.statusText,
            stackTrace: StackTrace.current,
          );
          _getStorage.write(Constants.USER_TOKEN, null);
        }
      } else {
        _isLogged(false);
      }
    });

    ever<bool?>(_isLogged, (isLogged) {
      if (isLogged == null || !isLogged) {
        Get.offAllNamed('/auth/login');
      } else {
        Get.offAllNamed('/home');
      }
    });

    final isLoggedData = getUserId() != null;

    _isLogged(isLoggedData);
    return this;
  }

  void logout() {
    _getStorage.write(Constants.USER_TOKEN, null);
  }

  String? getUserId() => _getStorage.read(Constants.USER_TOKEN);
}
