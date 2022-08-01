import 'package:consuni/app/models/message.dart';
import 'package:consuni/app/modules/chat_room/chat_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomPage extends StatefulWidget {
  final String username;
  const ChatRoomPage({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoomPage> {
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ChatRoomController controller = ChatRoomController();
  final username = Get.arguments['userChat'];

  _sendMessage() {
    _socket.emit('message',
        {'message': _messageInputController.text.trim(), 'sender': username});
    _messageInputController.clear();
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Conectado no socketIO'));
    _socket
        .onConnectError((data) => print('Erro ao conectar no SocketIo: $data'));
    _socket.onDisconnect((data) => print('Servidor Socket.IO disconectado'));
    _socket.on(
      'message',
      (data) => controller.addNewMessage(
        Message.fromJson(data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    _socket = IO.io(
      'http://192.168.0.18:3000',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': username}).build(),
    );
    _connectSocket();
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['userChat']),
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return Wrap(
                      alignment: message.senderUsername == widget.username
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      children: [
                        Card(
                          color: message.senderUsername == widget.username
                              ? Theme.of(context).primaryColorLight
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                                  message.senderUsername == widget.username
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(message.message),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  DateFormat('HH:mm').format(message.sentAt),
                                  // style: Theme.of(context).textTheme.caption,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: controller.messages.length,
                ),
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Escreva sua...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                        _sendMessage();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
