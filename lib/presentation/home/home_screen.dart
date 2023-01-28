import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_test/global/colors/colors.dart';
import 'package:todo_test/global/function/functions.dart';

import 'package:todo_test/model/task_model.dart';
import 'package:todo_test/presentation/add_task/add_task_screen.dart';
import 'package:todo_test/presentation/home/widget/app_bar_widget.dart';

import '../../controller/todo_controller.dart';
import 'widget/build_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseReference _todoListQuery;
  int dataIndex = 0;
  onBackPressed() {
    return SystemNavigator.pop();
  }

  final TodoController _todoController = Get.put(TodoController());
  @override
  void initState() {
    super.initState();
    _todoListQuery = _todoController.getTodoListQuery();
    _updateUserDb().whenComplete(() {
      try {
        _getTodoTasks();
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: message.notification!.title,
              body: message.notification!.body,
              notificationLayout: NotificationLayout.Default,
            ),
          );
        });
      } catch (e) {}
    });
  }

  void _getTodoTasks() async {
    _todoListQuery
      ..onChildAdded.listen((DatabaseEvent event) {
        if (event.snapshot.exists) {
          setState(() {
            dataIndex += 1;
          });
        }
      })
      ..onChildRemoved.listen((event) {
        if (mounted) {
          setState(() {
            dataIndex -= 1;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await TodoFunctions.backPressFunction(context);

        return shouldPop;
      },
      child: Scaffold(
        appBar: appBarWidget(context, _todoController),
        body: dataIndex == 0
            ? const Center(child: Text("Add New Task"))
            : FirebaseAnimatedList(
                defaultChild: const Center(child: CircularProgressIndicator()),
                shrinkWrap: true,
                query: _todoListQuery,
                itemBuilder: (context, snapshot, animation, index) {
                  return buildTask(
                      Task(
                          id: snapshot.key.toString(),
                          date: snapshot.child('date').value.toString(),
                          priority: snapshot.child('priority').value.toString(),
                          status: int.parse(
                              snapshot.child('status').value.toString()),
                          description:
                              snapshot.child('description').value.toString(),
                          title: snapshot.child('title').value.toString()),
                      context,
                      _todoController);
                },
              ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: const Icon(Icons.add_outlined),
            onPressed: () async {
              Get.to(() => const AddTaskScreen());
            }),
      ),
    );
  }

  Future<void> _updateUserDb() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    AwesomeNotifications().requestPermissionToSendNotifications();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      var token = await messaging.getToken();
      Future.delayed(const Duration(milliseconds: 3000), () {
        _todoController.updateUserToken(token!);
      });
    } else {}
  }
}
