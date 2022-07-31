import 'package:consuni_mobile/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni_mobile/app/models/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OnePage extends StatefulWidget {
  const OnePage({Key? key}) : super(key: key);

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _celularEC = TextEditingController();
  final _passwordEC = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _celularEC.dispose();
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
                      'Primeiro passo',
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
                      'Cadastre seus dados.',
                      style: context.textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextformfield(
                    label: 'Nome completo',
                    controller: _nameEC,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Nome completo é obrigatório';
                      } else if (!RegExp(r"\s").hasMatch(value.toString())) {
                        return 'Digite nome e sobrenome';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextformfield(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail é obrigatório'),
                      Validatorless.email('E-mail inválido'),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextformfield(
                    label: 'Celular',
                    cellMask: true,
                    controller: _celularEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Celular é obrigatório'),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
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
                    height: 10,
                  ),
                  CustomTextformfield(
                    label: 'Confirma senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar a senha é obrigatório'),
                      Validatorless.compare(
                          _passwordEC, 'Senha diferente de confirma senha'),
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
                          var model = RegisterViewModel(
                            name: _nameEC.text,
                            email: _emailEC.text,
                            celular: _celularEC.text,
                            password: _passwordEC.text,
                          );
                          print(model);
                          Navigator.pushNamed(context, '/two',
                              arguments: model);
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
