import 'package:consuni_mobile/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF140E0E), //cor de fundo da splash
        child: Stack(
          // empilha itens na tela
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context
                    .width, //adicionar antes o contextextensionss do get para usar o context.width
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover, //ajusta a imagem nas margens do fundo
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: context.heightTransformer(
                        reducedBy:
                            85), //usar o context do get para dar margem do topo de 15% do tamanho da tela
                  ),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(
                    height: 60,
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
