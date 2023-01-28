import 'package:flutter/material.dart';
import 'package:todo_test/global/colors/colors.dart';
import 'package:todo_test/model/task_model.dart';

PreferredSizeWidget addTaskAppBarWidget(BuildContext context,Task? task){
  return  AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Row(children: [
          Text(
           task == null ? 'Add Task' : 'Update Task',
            style: const TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ]),
         
        centerTitle: false,
        elevation: 0,
      );
}