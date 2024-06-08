import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/chat_screen_controller.dart';
import 'package:myapp/Models/chat_data_model.dart';
import 'package:myapp/widgets.dart';

class ChatDetailScreen extends StatelessWidget {
  final ChatDataModel chat;
  final ChatScreenController chatScreenController;

  const ChatDetailScreen({
    super.key,
    required this.chat,
    required this.chatScreenController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.green,
              child: Text(
                chat.userName[0],
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              chat.userName,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              // Add video call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.call,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              // Add voice call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert,
                color: Get.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              // Add more options functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: chat.messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  var message = chat.messages[index];
                  return MessageBubble(
                    isChatStarted: chat.chatStarted,
                    msg: message['text'],
                    time: message['time'],
                    isMe: message['isMe'],
                    isSent: true,
                    isImAi: chat.imGoogleAi,
                    chatScreenController: chatScreenController,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chat.textController,
                    decoration: InputDecoration(
                      hintText: chat.imGoogleAi
                          ? "Ask me anything..."
                          : 'Type a message...',
                      filled: true,
                      fillColor:
                          Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      hintStyle: TextStyle(
                        color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: () {
                      chatScreenController.sendMessage(
                        chat.textController.text,
                        context,
                        chat,
                      );
                      chat.chatStarted = true;
                    },
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: chatScreenController.gotAiResponse.value &&
                                chat.imGoogleAi
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
