import 'package:consuni_mobile/app/modules/chat/chat_bindings.dart';
import 'package:consuni_mobile/app/modules/chat/chat_page.dart';
import 'package:get/get.dart';

class ChatRouters {
  ChatRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/chat',
      binding: ChatBindings(),
      page: () => const ChatPage(),
    ),
  ];
}
