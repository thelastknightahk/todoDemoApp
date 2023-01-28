import 'dart:async';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_test/global/widgets/app_toasts.dart';
import 'package:todo_test/presentation/home/home_screen.dart';
import 'package:todo_test/presentation/signin/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkCondition();
  }

  Future _checkCondition() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Timer(const Duration(seconds: 1), () {
          Get.off(() => const HomeScreen());
        });
      } else {
        Timer(const Duration(seconds: 1), () {
          AppToasts.showToast(
              context: context, title: "Please Login Your Account");
          Get.off(() => const SignInPage());
        });
      }
    } else {
      AppToasts.showToast(context: context, title: "Check Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                        radius: 40.0,
                        child: Icon(
                          Icons.check_rounded,
                          color: Color(0xFF18D191),
                          size: 60.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Task Manager",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      CircularProgressIndicator(backgroundColor: Colors.white),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text(
                        "Hoshin labs",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 60.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
