import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ChatDataModel {
  final String userName;
  final String lastMessage;
  final String time;
  final bool online;
  final bool typing;
  TextEditingController textController = TextEditingController();
  RxList messages = [].obs;
  bool chatStarted;
  bool imGoogleAi;

  ChatDataModel(
      {required this.userName,
      required this.lastMessage,
      required this.time,
      required this.online,
      required this.typing,
      required this.messages,
      required this.textController,
      required this.chatStarted,
      this.imGoogleAi = false});

  // factory ChatDataModel.fromJson(Map<String, dynamic> json) {
  //   return ChatDataModel(
  //     name: json['name'],
  //     lastMessage: json['lastMessage'],
  //     time: json['time'],
  //     online: json['online'],
  //     typing: json['typing'],
  //     messages: json['messages'],
  //     textController: json['current message']
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'lastMessage': lastMessage,
  //     'time': time,
  //     'online': online,
  //     'typing': typing,
  //   };
  // }
}
