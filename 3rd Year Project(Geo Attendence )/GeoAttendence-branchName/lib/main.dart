import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Screens/Admin/NoOfStudents.dart';
import 'View/Screens/admin_Student_Screen.dart';
import 'View/auth/LoginPage.dart';
import 'View/auth/SignUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      getPages: [
        GetPage(
          name: "/",
          page: () => const AdminStudentScreen(),
        ),
        GetPage(
          name: "/loginPage",
          page: () => const LoginPage(),
        ),
        GetPage(
          name: "/SignUpPage",
          page: () => const SignupPage(),
        ),
        GetPage(name: "/allStudents", page: () => const NoOfStuds())
      ],
    );
  }
}
