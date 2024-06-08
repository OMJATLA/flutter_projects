
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/Controllers/chat_screen_controller.dart';
import 'package:myapp/Models/chat_data_model.dart';

import 'Screens/Chat Screen/chat_detailed_screen.dart';

class ChatTile extends StatelessWidget {
  final ChatDataModel chat;

  const ChatTile({
    super.key,
    required this.chat,
    required this.chatScreenController,
  });

  final ChatScreenController chatScreenController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: CircleAvatar(
        radius: 28.0,
        backgroundColor: chat.online ? Colors.green : Colors.grey[300],
        child: Text(
          chat.userName[0],
          style: const TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
      title: Text(
        chat.userName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Obx(
              () => Text(
                chat.messages[0]['text'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Obx(
            () => Text(
              chat.messages[0]['time'],
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (chat.typing)
            const Text('Typing...', style: TextStyle(color: Colors.green)),
          if (chat.typing) const SizedBox(height: 4.0),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: chat.online ? Colors.green : Colors.grey,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              chat: chat,
              chatScreenController: chatScreenController,
            ),
          ),
        );
      },
    );
  }
}

// message buubl
class MessageBubble extends StatelessWidget {
  final String msg;
  final String time;
  final bool isMe;
  final bool isSent;
  final bool isChatStarted;
  final bool isImAi;
  final ChatScreenController chatScreenController;

  const MessageBubble(
      {super.key,
      required this.msg,
      required this.time,
      required this.isMe,
      required this.isSent,
      required this.isChatStarted,
      required this.isImAi,
      required this.chatScreenController});

  @override
  Widget build(BuildContext context) {
    return isChatStarted == false || msg == ""
        ? isChatStarted
            ? const SizedBox()
            : const Center(
                child: Text("No chats..."),
              )
        : Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.green : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (msg.isNotEmpty) // Display message if not empty
                        Text(
                          msg,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      const SizedBox(height: 4.0),
                      Text(
                        time,
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.black45,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isMe && isSent)
                  const Positioned(
                    bottom: 47,
                    right: 5,
                    top: 0,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 18,
                    ), // Sent icon
                  ),
              ],
            ),
          );
  }
}
