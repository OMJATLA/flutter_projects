import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../Widgets/colors.dart';
import '../../Widgets/widgets.dart';
import '../../utils/getting_gmail.dart';
import '../Screens/Admin/AdminHome.dart';
import '../Screens/Student/student_home.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final title = Get.arguments[0];

  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  void login() {
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) async {
      setState(() {
        loading = false;
      });
      await getlist(auth.currentUser!.email)
          ? title == 'Admin Login'
              ? Get.to(const AdminHome())
              : adminOrStudentPageDecision(errorMsg: 'This is a Student Login!')
          : title == 'Student Login'
              ? Get.to(const StudentHome())
              : adminOrStudentPageDecision(errorMsg: 'This is a Admin Login!');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Invaild password or email'),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminstubackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'image',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/login.png',
                            fit: BoxFit.fill,
                            height: 200,
                            // width: 120,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        title.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: darkBlue),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Textfield(
                                controller: emailController,
                                labelText: 'Email',
                                labelValidator: 'Email Required',
                                icon: Icons.email_outlined),
                            Textfield(
                                obscureText: true,
                                controller: passController,
                                labelText: 'Password',
                                labelValidator: 'Password Required',
                                icon: Icons.lock)
                          ],
                        )),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    ReuseableMaterialButton(
                        heroTag: title == 'Student Login'
                            ? 'studentTag'
                            : 'adminTag',
                        loading: loading,
                        clr: lightOrange,
                        buttonText: 'Login',
                        width: double.infinity,
                        callback: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            login();
                          }
                        }),
                    title == "Student Login"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account'),
                              TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage())),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(color: darkBlue),
                                  ))
                            ],
                          )
                        : const SizedBox()
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
