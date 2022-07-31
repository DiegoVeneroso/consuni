import 'package:consuni_mobile/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni_mobile/app/models/view_models/register_view_model.dart';
import 'package:consuni_mobile/app/modules/auth/register/register_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ThreePage extends StatefulWidget {
  const ThreePage({Key? key}) : super(key: key);

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  final _formKey = GlobalKey<FormState>();
  final _representanteEC = TextEditingController();
  final _portariaEC = TextEditingController();
  final _whatsEC = TextEditingController();
  late RegisterViewModel registerViewModel;
  RegisterController registerController = Get.find();
  RxBool isRepresentante = false.obs;
  final acceptTerms = false.obs;

  final List<String> genderItems = [
    'Representado',
    'Representante',
  ];

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      registerViewModel =
          ModalRoute.of(context)?.settings.arguments as RegisterViewModel;
    });
  }

  @override
  void dispose() {
    _representanteEC.dispose();
    _portariaEC.dispose();
    _whatsEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
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
                      'Terceiro passo',
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
                      'Cadastre se você é representante ou representado.',
                      style: context.textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: const TextStyle(color: Colors.black),
                      errorStyle: const TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Tipo',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'mplus1',
                          color: Colors.black),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 30,
                    buttonHeight: 25,
                    buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    items: genderItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Tipo é obrigatório';
                      }
                    },
                    onChanged: (value) {
                      selectedValue = value.toString();
                      if (value.toString() == 'Representado') {
                        isRepresentante.value = false;
                      } else {
                        isRepresentante.value = true;
                      }
                    },
                  ),
                  Obx(
                    () => Visibility(
                      visible: isRepresentante.value,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: isRepresentante.value,
                      child: CustomTextformfield(
                        label: 'Portaria da designação',
                        controller: _portariaEC,
                        validator: Validatorless.multiple([
                          Validatorless.required(
                              'Portaria da designação é obrigatório'),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Visibility(
                      visible: isRepresentante.value,
                      child: CustomTextformfield(
                        label: 'Whatsapp',
                        cellMask: true,
                        controller: _whatsEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Celular é obrigatório'),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          child: Obx(() => Checkbox(
                                value: acceptTerms.value,
                                onChanged: (value) {
                                  acceptTerms.value = value as bool;
                                  print(acceptTerms.value);
                                },
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.defaultDialog();
                          },
                          child: const Text(
                            'Aceito os termos e condições de uso',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Obx(() => CustomButtom(
                          width: context.width,
                          label: 'CADASTRAR',
                          disable: !acceptTerms.value,
                          onPressed: () async {
                            String pushtoken = await FirebaseMessaging.instance
                                .getToken()
                                .then((value) => value.toString());
                            final formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              var model = registerViewModel.copyWith(
                                tokenPush: pushtoken,
                                representante: selectedValue == 'Representante'
                                    ? true
                                    : false,
                              );
                              print(model);

                              registerController.register(model);
                            }
                          },
                        )),
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
