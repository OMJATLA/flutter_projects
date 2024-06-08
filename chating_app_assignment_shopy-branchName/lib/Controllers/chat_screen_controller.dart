import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myapp/Models/chat_data_model.dart';

class ChatScreenController extends GetxController {
  RxList<ChatDataModel> chatDataList = <ChatDataModel>[].obs;
  RxBool gotAiResponse = false.obs;

  void sendMessage(
      String text, BuildContext context, ChatDataModel chatDataModel) {
    if (text.isNotEmpty) {
      chatDataModel.messages.insert(
        0,
        {'text': text, 'time': getCurrentTime(context), 'isMe': true},
      );
      chatDataModel.textController.clear();

      if (chatDataModel.imGoogleAi == true) {
        // recive from Ai
        gotAiResponse.value = true;
        reciveMsgFromAi(context, chatDataModel, text);
      } else {
        // get a response after 1 sec like This is a response...............................
        receiveMessage(context, chatDataModel);
      }

      // googleAi(msg: text);
      // reciveMsgFromAi(context, chatDataModel, text);
    }

    sortByTime();
  }

  reciveMsgFromAi(
      BuildContext context, ChatDataModel chatDataModel, String msg) {
    Future.delayed(const Duration(seconds: 0), () async {
      // List<Content> historyOfChatList = [];
      // for (var i = 0; i < chatDataModel.messages.length; i++) {
      //   print(chatDataModel.messages[i]['text']);
      //   if (chatDataModel.messages[i]["isMe"] == true) {
      //     print(chatDataModel.messages[i]['text']);
      //     historyOfChatList
      //         .add(Content.text(chatDataModel.messages[i]['text']));
      //   }
      // }
      chatDataModel.messages.insert(
        0,
        {
          'text': await googleAi(
            msg: msg,
          ),
          // ignore: use_build_context_synchronously
          'time': getCurrentTime(context),
          'isMe': false,
          'isSent': true, // Mark response as sent
        },
      );
    });
  }

  void receiveMessage(BuildContext context, ChatDataModel chatDataModel) {
    Future.delayed(const Duration(seconds: 1), () {
      chatDataModel.messages.insert(
        0,
        {
          'text': 'This is a response',
          'time': getCurrentTime(context),
          'isMe': false,

          'isSent': true, // Mark response as sent
        },
      );
    });
  }

  String getCurrentTime(BuildContext context) {
    return TimeOfDay.now().format(context);
  }

  void getAllChatData() {
    chatDataList.add(ChatDataModel(
      chatStarted: true,
      userName: "Gemini AI 🤖",
      lastMessage: "",
      time: "8:00 AM",
      online: true,
      typing: false,
      imGoogleAi: true,
      messages: [
        {
          'text': "",
          'time': "",
          'isMe': true,
        }
      ].obs,
      textController: TextEditingController(),
    ));
    chatDataList.add(ChatDataModel(
      chatStarted: true,
      userName: "Rohan",
      lastMessage: "Hello",
      time: "8:00 AM",
      online: false,
      typing: false,
      messages: [
        {'text': "hello", 'time': "8:00 AM", 'isMe': false}
      ].obs,
      textController: TextEditingController(),
    ));
    // sorting by time...................................
  }

  void sortByTime() {
    chatDataList
        .sort((a, b) => b.messages[0]['time'].compareTo(a.messages[0]['time']));
  }

  @override
  void onInit() {
    super.onInit();
    getAllChatData();
  }

  // ai

  final String apiKey = "AIzaSyCEh-Jeu64O8vSzeFXOyBTlaACqf55sILw";

  Future<String> googleAi({
    required String msg,
  }) async {
    gotAiResponse.value = true;
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    final prompt = msg;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    // final response = model.startChat(history: chatHistory);

    // final responseMsg = await response.sendMessage(Content.text(prompt));
    // print(response.sendMessage(Content.text(prompt)));
    gotAiResponse.value = false;
    return response.text.toString();
  }
}
