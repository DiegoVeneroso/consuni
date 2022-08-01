import 'package:consuni/app/core/ui/app_state.dart';
import 'package:consuni/app/core/ui/app_ui.dart';
import 'package:consuni/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends AppState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: context.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextformfield(
                          label: 'Email',
                          controller: _emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('E-mail é obrigatório'),
                            Validatorless.email('E-mail inválido'),
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextformfield(
                          label: 'Senha',
                          obscureText: true,
                          controller: _passwordEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha é obrigatório'),
                            Validatorless.min(
                                6, 'Senha deve ter no mínimo 6 caracteres'),
                          ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: CustomButtom(
                              width: context.width,
                              label: 'ENTRAR',
                              onPressed: () {
                                final formValid =
                                    _formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  controller.login(
                                    email: _emailEC.text,
                                    password: _passwordEC.text,
                                  );
                                }
                              }),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Esqueceu a senha?'),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/auth/password_recovery');
                              },
                              child: const Text(
                                'Recuperar senha',
                                style: AppUI.textbold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Chat'),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/chat');
                              },
                              child: const Text(
                                'Chat',
                                style: AppUI.textbold,
                              ),
                            ),
                          ],
                        ), //empurra o próximo elemento para o rodapé da tela
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Não possui uma conta?'),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/auth/register');
                              },
                              child: const Text(
                                'Cadastre-se',
                                style: AppUI.textbold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
