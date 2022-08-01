import 'package:consuni/app/core/ui/app_state.dart';
import 'package:consuni/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni/app/modules/auth/password_renew/password_renew_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class PasswordRenewPage extends StatefulWidget {
  const PasswordRenewPage({Key? key}) : super(key: key);

  @override
  State<PasswordRenewPage> createState() => _PasswordRenewPageState();
}

class _PasswordRenewPageState
    extends AppState<PasswordRenewPage, PasswordRenewController> {
  final _formKey = GlobalKey<FormState>();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        IconBackNavigator: true,
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Recuperação de senha',
                      style: context.textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColorDark,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cadastre uma nova senha para acesso.',
                      style: context.textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextformfield(
                    label: 'Nova senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Nova senha é obrigatório'),
                      Validatorless.min(
                          6, 'Nova senha deve ter no mínimo 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextformfield(
                    label: 'Confirma nova senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required(
                          'Confirmar a nova senha é obrigatório'),
                      Validatorless.compare(_passwordEC,
                          'Nova senha diferente de confirma nova senha'),
                    ]),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CustomButtom(
                      width: context.width,
                      label: 'PRÓXIMO',
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? true;
                        if (formValid) {
                          // var model = RegisterViewModel(
                          //   name: _nameEC.text,
                          //   email: _emailEC.text,
                          //   celular: _celularEC.text,
                          //   password: _passwordEC.text,
                          // );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
