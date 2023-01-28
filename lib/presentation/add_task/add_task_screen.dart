import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_test/controller/todo_controller.dart';
import 'package:todo_test/global/colors/colors.dart'; 

import 'package:todo_test/model/task_model.dart';
import 'package:todo_test/presentation/add_task/widget/add_task_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  final Function? updateTaskList;
  final Task? task;

  const AddTaskScreen({super.key, this.updateTaskList, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _priority = 'Low';
  String _status = '';
  DateTime _date = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd,yyyy');

  final List<String> _priorities = ['Low', 'Medium', 'High'];
  final TodoController _todoController = Get.find();
  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _title = widget.task!.title!;
      _description = widget.task!.description!;
      _status = widget.task!.status.toString();
      _date = DateFormat('MMM dd,yyyy').parse('${widget.task!.date}');
      _priority = widget.task!.priority!;
      
    _titleController.text = _title;
    _descriptionController.text = _description;
    }
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

 

  _submit() async {
    if (widget.task == null) {
      _todoController.addTodoList(
          Task(
              title: _titleController.text.toString(),
              description: _descriptionController.text.toString(),
              date: _dateFormatter.format(_date).toString(),
              priority: _priority,
              status: 0),
          context);
      Future.delayed(const Duration(milliseconds: 500), () {
        _titleController.text = '';
        _descriptionController.text = '';
      });
    } else {
      _todoController.updateTodoList(
          Task(
              id: widget.task!.id.toString(),
              title: _titleController.text.toString(),
              description: _descriptionController.text.toString(),
              date: _dateFormatter.format(_date).toString(),
              priority: _priority,
              status: int.parse(_status)),
          context);
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addTaskAppBarWidget(context, widget.task),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: TextField(
                              cursorColor: AppColor.primaryColor,
                              controller: _titleController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Title',
                                hintStyle:
                                    TextStyle(color: AppColor.blackColor54),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: TextField(
                            readOnly: true,
                            controller: _dateController,
                            style: const TextStyle(
                                fontSize: 16.0, color: AppColor.blackColor54),
                            onTap: _handleDatePicker,
                            decoration: const InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(fontSize: 16.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonFormField(
                              isDense: true,
                              icon: const Icon(Icons.arrow_drop_down_circle),
                              iconSize: 22.0,
                              iconEnabledColor: Theme.of(context).primaryColor,
                              items: _priorities.map((String priority) {
                                return DropdownMenuItem(
                                  value: priority,
                                  child: Text(
                                    priority,
                                    style: const TextStyle(
                                      color: AppColor.blackColor54,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                );
                              }).toList(),
                              style: const TextStyle(fontSize: 16.0),
                              decoration: const InputDecoration(
                                labelText: 'Priority',
                                labelStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.primaryColor),
                                border: InputBorder.none,
                              ),
                              validator: (input) => _priority == null
                                  ? 'Please select a priority level'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _priority = value!;
                                });
                              },
                              value: _priority,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: TextField(
                            cursorColor: AppColor.primaryColor,
                            maxLines: 3,
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description',
                              hintStyle:
                                  TextStyle(color: AppColor.blackColor54),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(
                            widget.task == null ? 'Add' : 'Update',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      widget.task != null
                          ? Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.warnColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _todoController.deleteTodoList(widget.task!.id!, context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            )
                          
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
