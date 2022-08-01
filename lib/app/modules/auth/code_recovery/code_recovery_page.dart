import 'package:consuni/app/core/ui/app_state.dart';
import 'package:consuni/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni/app/modules/auth/code_recovery/code_recovery_controller.dart';
import 'package:consuni/app/modules/auth/password_recovery/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class CodeRecoveryPage extends StatefulWidget {
  const CodeRecoveryPage({Key? key}) : super(key: key);

  @override
  State<CodeRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState
    extends AppState<CodeRecoveryPage, CodeRecoveryController> {
  final _formKey = GlobalKey<FormState>();
  final _codeEC = TextEditingController();
  @override
  CodeRecoveryController controller = Get.find();

  @override
  void dispose() {
    _codeEC.dispose();
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
                          'Código de recuperação',
                          style: context.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextformfield(
                          label: 'código',
                          controller: _codeEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Código é obrigatório'),
                          ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: CustomButtom(
                            width: context.width,
                            label: 'VALIDAR CÓDIGO',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                controller.validadeCode(
                                    email: Get.arguments['email'],
                                    code: int.parse(_codeEC.text));
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
