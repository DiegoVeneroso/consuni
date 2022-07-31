import 'package:get/get.dart';
import './chat_room_controller.dart';

class ChatRoomBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ChatRoomController());
    }
}