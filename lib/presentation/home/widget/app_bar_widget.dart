 
import 'package:flutter/material.dart';
import 'package:todo_test/controller/todo_controller.dart'; 

PreferredSizeWidget appBarWidget(BuildContext context, TodoController todoController){
  return AppBar(
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            leading: const IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: null),
            title: Row(
              children: const [
                Text(
                  "Task",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    letterSpacing: -1.2,
                  ),
                ),
                Text(
                  "Manager",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0,
                  ),
                )
              ],
            ),
            centerTitle: false,
            elevation: 0,
            actions: [
            
              Container(
                margin: const EdgeInsets.all(6.0),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  iconSize: 25.0,
                  color: Colors.black,
                  
                  onPressed: () {
                     todoController.signOut();
                  },
                ),
              )
            ],
          );
}