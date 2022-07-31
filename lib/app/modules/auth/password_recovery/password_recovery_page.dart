import 'package:consuni_mobile/app/core/ui/app_state.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni_mobile/app/modules/auth/password_recovery/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState
    extends AppState<PasswordRecoveryPage, PasswordRecoveryController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  PasswordRecoveryController controller = Get.find();

  @override
  void dispose() {
    _emailEC.dispose();
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
                          'Recuperar senha',
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
                          height: 50,
                        ),
                        Center(
                          child: CustomButtom(
                            width: context.width,
                            label: 'RECUPERAR',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                controller.recoveryPassword(
                                    email: _emailEC.text);
                              }
                            },
                          ),
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
