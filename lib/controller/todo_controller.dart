import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; 
import 'package:todo_test/global/firebase/firebase_data.dart';
import 'package:todo_test/global/widgets/app_toasts.dart';
import 'package:todo_test/model/task_model.dart';
import 'package:todo_test/presentation/signin/sign_in_page.dart';

class TodoController extends GetxController {
  final user = FirebaseAuth.instance.currentUser; 

  DatabaseReference getTodoListQuery() {
    DatabaseReference todoListQuery =
        FirebaseConstant.firebaseDatabaseRef.ref('Todo/${user!.uid}/tasks/');
    todoListQuery.onChildAdded.listen((DatabaseEvent event) {});
    return todoListQuery;
  }

  updateUserToken(String token) async{
     FirebaseConstant.firebaseDatabaseRef
        .ref('Users/${user!.uid}/')
   
        .set({
      "token": token.toString().trim(),
      
    }).then(
      (value) {
        
      },
    );
  }

  sendUserNoti(String textContent) async{
      FirebaseConstant.firebaseDatabaseRef
        .ref('Users/${user!.uid}/').once().then((value) async{
         
            try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Authorization"] =
          "key=AAAAQoWj_-E:APA91bGumQuGlJWNq2O42mB4cDkmJENd6g0qjTTrKL5v4YSzP1JJPyzE2lrZX79E2ADV4-6dggmCTJPqRse0tnxev9pY8KlXMDCsdy-mMzlfv6yu9w5dPMic1Q7Cvaz97nHuI4bUSk4m";
      var params = {
        'to': value.snapshot.child('token').value.toString().trim(),
        'priority': 'high',
        'notification': {
          'title': 'TodoApp Notification',
          'body': textContent
        }
      };
      await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: jsonEncode(params),
      ).then((value) {
        print("Sent");
      });
    } catch (e) {}
        });
  
  }

    
  addTodoList(Task task, BuildContext context) {
    FirebaseConstant.firebaseDatabaseRef
        .ref('Todo/${user!.uid}/tasks/')
        .push()
        .set({
      "title": task.title.toString().trim(),
      "description": task.description.toString().trim(),
      "status": task.status,
      "date": task.date,
      "priority": task.priority
    }).then(
      (value) {
        sendUserNoti("Added New Task");
        AppToasts.showToast(context: context, title: "Successfully Added");
      },
    );
  }

  updateTodoList(Task task, BuildContext context) {
    FirebaseConstant.firebaseDatabaseRef
        .ref('Todo/${user!.uid}/tasks/${task.id}')
        .set({
      "title": task.title.toString().trim(),
      "description": task.description.toString().trim(),
      "status": task.status,
      "date": task.date,
      "priority": task.priority
    }).then(
      (value) {
        sendUserNoti("Updated Task");
        AppToasts.showToast(context: context, title: "Successfully Updated");
      },
    );
  }

  deleteTodoList(String taskId, BuildContext context) {
    FirebaseConstant.firebaseDatabaseRef
        .ref('Todo/${user!.uid}/tasks/$taskId')
        .remove()
        .then(
      (value) {
        sendUserNoti("Deleted Task");
        AppToasts.showToast(context: context, title: "Successfully Deleted");
      },
    ).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.back();
      });
    });
  }

  signOut(){
    FirebaseAuth.instance.signOut().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.off(()=> const  SignInPage() );
      });
    });
  }
}
