import 'package:consuni/app/core/ui/app_state.dart';
import 'package:consuni/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni/app/core/ui/widgets/custom_buttom.dart';
import 'package:consuni/app/core/ui/widgets/custom_textformfield.dart';
import 'package:consuni/app/modules/auth/password_recovery/password_recovery_controller.dart';
import 'package:consuni/app/modules/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends AppState<ChatPage, ChatController> {
  final _formKey = GlobalKey<FormState>();
  final _nomeEC = TextEditingController();
  @override
  ChatController controller = Get.find();

  @override
  void dispose() {
    _nomeEC.dispose();
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
                          'Nome do usuario',
                          style: context.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextformfield(
                          label: 'Nome',
                          controller: _nomeEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Nome é obrigatório'),
                          ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: CustomButtom(
                            width: context.width,
                            label: 'ENTRAR NO CHAT',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                Get.toNamed(
                                  '/chat_room',
                                  arguments: {"userChat": _nomeEC.text},
                                );
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
