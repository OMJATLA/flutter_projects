import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Screens/Chat%20Screen/chats_screen.dart';
// import 'package:myapp/Screens/chats_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Your light theme data here
        brightness: Brightness.light,
        // other theme properties...
      ),
      darkTheme: ThemeData(
        // Your dark theme data here
        brightness: Brightness.dark,
        // other dark theme properties...
      ),
      themeMode: ThemeMode.system, // Use system theme by default
      home: ChatsScreen(),
    );
  }
}
