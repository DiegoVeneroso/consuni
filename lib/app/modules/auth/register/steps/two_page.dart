import 'package:consuni_mobile/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni_mobile/app/models/view_models/register_view_model.dart';
import 'package:consuni_mobile/app/modules/auth/register/register_controller.dart';
import 'package:consuni_mobile/app/repositories/auth/auth_repository_impl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

class TwoPage extends StatefulWidget {
  TwoPage({Key? key}) : super(key: key);

  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  final _formKey = GlobalKey<FormState>();
  final _instituicaoEC = TextEditingController();
  final _classeEC = TextEditingController();
  final _cargoEC = TextEditingController();
  final _funcaoEC = TextEditingController();
  late RegisterViewModel registerViewModel;
  RegisterController registerController = Get.find();
  RxBool isServidor = false.obs;
  String? selectedInstituicao;
  String? selectedClasse;

  @override
  void dispose() {
    _instituicaoEC.dispose();
    _classeEC.dispose();
    _cargoEC.dispose();
    _funcaoEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      registerViewModel =
          ModalRoute.of(context)?.settings.arguments as RegisterViewModel;
    });
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
                      'Segundo passo',
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
                      'Cadastre seus dados intitucionais.',
                      style: context.textTheme.bodyText1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List?>(
                    future: registerController.getInstituicao(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: const TextStyle(color: Colors.black),
                            errorStyle:
                                const TextStyle(color: Colors.redAccent),
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
                            'Instituição',
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
                          buttonPadding:
                              const EdgeInsets.only(left: 0, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          value: selectedInstituicao,
                          items: snapshot.data!.map((location) {
                            return DropdownMenuItem(
                              child: Text(location),
                              value: location,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedInstituicao = newValue.toString();
                            });
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List?>(
                    future: registerController.getClasse(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: const TextStyle(color: Colors.black),
                            errorStyle:
                                const TextStyle(color: Colors.redAccent),
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
                            'Classe',
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
                          buttonPadding:
                              const EdgeInsets.only(left: 0, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          value: selectedClasse,
                          items: snapshot.data!.map((location) {
                            return DropdownMenuItem(
                              child: Text(location),
                              value: location,
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedClasse = value.toString();
                            if (value.toString() == 'Discente') {
                              isServidor.value = false;
                            } else {
                              isServidor.value = true;
                            }
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  // DropdownButtonFormField2(
                  //   decoration: InputDecoration(
                  //     isDense: true,
                  //     labelStyle: const TextStyle(color: Colors.black),
                  //     errorStyle: const TextStyle(color: Colors.redAccent),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(23),
                  //       borderSide: BorderSide(color: Colors.grey[400]!),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(23),
                  //       borderSide: BorderSide(color: Colors.grey[400]!),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(23),
                  //       borderSide: BorderSide(color: Colors.grey[400]!),
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //   ),
                  //   isExpanded: true,
                  //   hint: const Text(
                  //     'Classe',
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontFamily: 'mplus1',
                  //         color: Colors.black),
                  //   ),
                  //   icon: const Icon(
                  //     Icons.arrow_drop_down,
                  //     color: Colors.black,
                  //   ),
                  //   iconSize: 30,
                  //   buttonHeight: 25,
                  //   buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                  //   dropdownDecoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(23),
                  //   ),
                  //   items: genderItems2
                  //       .map((item) => DropdownMenuItem<String>(
                  //             value: item,
                  //             child: Text(
                  //               item,
                  //               style: const TextStyle(
                  //                 fontSize: 14,
                  //               ),
                  //             ),
                  //           ))
                  //       .toList(),
                  //   validator: (value) {
                  //     if (value == null) {
                  //       return 'Classe é obrigatória';
                  //     }
                  //   },
                  // onChanged: (value) {
                  //   selectedClasse = value.toString();
                  //   if (value.toString() == 'Discente') {
                  //     isServidor.value = false;
                  //   } else {
                  //     isServidor.value = true;
                  //   }
                  //   },
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Visibility(
                      visible: isServidor.value,
                      child: CustomTextformfield(
                        label: 'Cargo',
                        controller: _cargoEC,
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: isServidor.value,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: isServidor.value,
                      child: CustomTextformfield(
                        label: 'Função (opcional)',
                        controller: _funcaoEC,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CustomButtom(
                      width: context.width,
                      label: 'PRÓXIMO',
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          var model = registerViewModel.copyWith(
                            instituicao: selectedInstituicao,
                            classe: selectedClasse,
                            cargo: _cargoEC.text,
                            funcao: _funcaoEC.text,
                          );
                          print(model);
                          Navigator.pushNamed(context, '/three',
                              arguments: model);
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
  }
}
