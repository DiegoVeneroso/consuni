import 'package:consuni/app/modules/chat_room/chat_room_bindings.dart';
import 'package:consuni/app/modules/chat_room/chat_room_page_new.dart';
import 'package:get/get.dart';

class ChatRoomRouters {
  ChatRoomRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/chat_room',
      binding: ChatRoomBindings(),
      page: () => ChatRoomPage(
          // username: Get.arguments['userChat'],
          ),
    ),
  ];
}
