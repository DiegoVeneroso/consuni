import 'package:consuni/app/models/message.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  final List<Message> _messages = [
    Message(
      message: 'Oi',
      senderUsername: 'Diego1',
      sentAt: DateTime.parse('2022-03-03 23:09:00'),
    )
  ].obs;

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
  }
}
