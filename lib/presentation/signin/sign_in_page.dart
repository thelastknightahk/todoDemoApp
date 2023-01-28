import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_test/global/colors/colors.dart';
import 'package:todo_test/global/widgets/app_button.dart';
import 'package:todo_test/global/widgets/app_toasts.dart';
import 'package:todo_test/global/widgets/text_input_widget.dart';
import 'package:todo_test/presentation/home/home_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _pwdTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.whteColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      'Login',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(child: Image.asset('assets/todo_img.png')),
                  const SizedBox(
                    height: 70.0,
                  ),
                  TextInputWidget(
                    textEditingController: _emailTextEditingController,
                    password: false,
                    foreIcon: const Icon(
                      Icons.person,
                      color: AppColor.primaryColor,
                    ),
                    textContent: 'Email',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextInputWidget(
                    textEditingController: _pwdTextEditingController,
                    password: true,
                    foreIcon: const Icon(
                      Icons.lock,
                      color: AppColor.primaryColor,
                    ),
                    textContent: 'Password',
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  Center(
                      child: AppButtonWidget(
                    clickFunction: () async {
                      AppToasts.showToast(
                          context: context, title: 'Please Wait!');
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextEditingController.text,
                                password: _pwdTextEditingController.text)
                            .then((value) {
                          AppToasts.showToast(
                              context: context, title: 'Successful Sign In!');
                          Get.off(() => const HomeScreen());
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          AppToasts.showErrorToast(
                              context: context,
                              title: 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          AppToasts.showErrorToast(
                              context: context,
                              title: 'Wrong password provided for that user.');
                        }
                      }
                    },
                    content: 'Sign In',
                  )),
                  const SizedBox(
                    height: 70.0,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  
 

}
