import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

mixin LoaderMixin on GetxController {
  void loaderListener(RxBool loading) {
    ever(loading, (_) async {
      if (loading.isTrue) {
        await Get.dialog(
          WillPopScope(
            // não deixa o usuario clicar voltar para fechar o loading
            onWillPop: () async => false,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          barrierDismissible: false, // bloqueio clicar fora e fechar o loading
        );
      } else {
        Get.back();
      }
    });
  }
}
