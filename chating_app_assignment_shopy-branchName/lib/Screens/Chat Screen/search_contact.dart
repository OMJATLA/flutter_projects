import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/chat_screen_controller.dart';
import 'package:myapp/Models/chat_data_model.dart';
import 'package:myapp/Screens/Chat%20Screen/chat_detailed_screen.dart';
import 'package:myapp/widgets.dart';

class ChatSearchDelegate extends SearchDelegate<String> {
  ChatSearchDelegate({required this.chatScreenController});
  final ChatScreenController chatScreenController;

  @override
  String get searchFieldLabel => 'Search Contacts';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter contacts based on query
    List<ChatDataModel> filteredContacts =
        chatScreenController.chatDataList.where((chat) {
      final name = chat.userName.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    // Display filtered contacts
    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        ChatDataModel chat = filteredContacts[index];
        return ListTile(
          title: Text(chat.userName),
          onTap: () {
            // close(context, chat.userName);
            Get.to(ChatDetailScreen(
              chat: chat,
              chatScreenController: chatScreenController,
            ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display search suggestions
    final List<ChatDataModel> suggestions = query.isEmpty
        ? chatScreenController.chatDataList
        : chatScreenController.chatDataList.where((chat) {
            final name = chat.userName.toLowerCase();
            return name.contains(query.toLowerCase());
          }).toList();

    return suggestions.isEmpty
        ? const Center(
            child: Text("No contacts found"),
          )
        : ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              ChatDataModel chat = suggestions[index];
              return ChatTile(
                chat: chat,
                chatScreenController: chatScreenController,
              );
            },
          );
  }
}
