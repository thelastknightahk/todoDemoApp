import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test/controller/todo_controller.dart';
import 'package:todo_test/model/task_model.dart';
import 'package:todo_test/presentation/add_task/add_task_screen.dart';

Widget buildTask(
    Task task, BuildContext context, TodoController todoController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Column(
      children: <Widget>[
        // if (task.status == 0)
        ListTile(
          title: Text(
            task.title!,
            style: TextStyle(
              fontSize: 18.0,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            '${task.date}  • ${task.priority}',
            style: TextStyle(
              fontSize: 15.0,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          trailing: Checkbox(
            onChanged: (value) {
              task.status = value! ? 1 : 0;
              todoController.updateTodoList(
                  Task(
                      id: task.id,
                      date: task.date,
                      priority: task.priority,
                      status: task.status,
                      description: task.description,
                      title: task.title),
                  context);
            },
            activeColor: Theme.of(context).primaryColor,
            value: task.status == 1 ? true : false,
          ),
          onTap: () {
            Get.to(() => AddTaskScreen(
                  task: task,
                ));
          },
        ),
        const Divider(),
      ],
    ),
  );
}
