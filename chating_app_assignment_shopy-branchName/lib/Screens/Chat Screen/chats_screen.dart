import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/chat_screen_controller.dart';
import 'package:myapp/Models/chat_data_model.dart';
import 'package:myapp/Screens/Chat%20Screen/search_contact.dart';
import 'package:myapp/widgets.dart';

class ChatsScreen extends StatelessWidget {
  final ChatScreenController chatScreenController =
      Get.put(ChatScreenController());

  ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
              showSearch(
                context: context,
                delegate: ChatSearchDelegate(
                  chatScreenController: chatScreenController,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6), // Dark theme switch icon
            onPressed: () {
              // Toggle between light and dark themes
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: chatScreenController.chatDataList.length,
          itemBuilder: (context, index) {
            ChatDataModel chat = chatScreenController.chatDataList[index];
            return ChatTile(
              chat: chat,
              chatScreenController: chatScreenController,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCustomerBottomSheet(context);
        },
        backgroundColor: Get.isDarkMode
            ? const Color.fromARGB(255, 15, 121, 19)
            : Colors.green[50],
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCustomerBottomSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    bool buttonPressed = false; // Variable to track if the button was pressed

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Add New Contact',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Contact Name',
                          labelStyle: TextStyle(color: Colors.green[900]),
                          errorText:
                              buttonPressed && nameController.text.isEmpty
                                  ? 'Please enter a name'
                                  : null,
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonPressed = true;
                          });
                          if (nameController.text.isNotEmpty) {
                            chatScreenController.chatDataList.add(ChatDataModel(
                              chatStarted: false,
                              userName: nameController.text,
                              lastMessage: "",
                              time:
                                  chatScreenController.getCurrentTime(context),
                              online: true,
                              typing: false,
                              messages: [
                                {
                                  'text': "",
                                  'time': chatScreenController
                                      .getCurrentTime(context),
                                  'isMe': true
                                }
                              ].obs,
                              textController: TextEditingController(),
                            ));
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: const Text(
                          'Add Contact',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
