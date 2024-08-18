// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:to_do_app/services/todo_service.dart';

import 'utils/snackbar_helper.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
class Addpage extends StatefulWidget {
  final Map? todo;
  const Addpage({super.key,
  this.todo,
  });

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  bool isedit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (widget.todo != null) {
      isedit = true;
      final title = todo?['title'];
      final description = todo?['description'];
      titlecontroller.text = title;
      descriptioncontroller.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              isedit ? 'Edit Todo' : 'Add Todo'),
          backgroundColor: Colors.blueGrey,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [

            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: descriptioncontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Description'),
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(height: 6.0,),
            ElevatedButton(onPressed: isedit ? updatedata : submitdata,
                child: Text(isedit ? 'Update' : 'Submit',))
          ],
        )
    );
  }

  void updatedata() async {
    final todo = widget.todo;
    if (todo == null) {
      print('you cannot call updated data without todo data');
      return;
    }
    final id = todo['_id'];


    final isSuccess = await TodoService.updateTodo(id, body);
    if (isSuccess) {
      titlecontroller.text = '';
      descriptioncontroller.text = '';
      showsuccessmessage(context, message: 'Updation success');
    } else {
      showErrorMessage(context, message: 'Updation failed');
    }
  }

  void submitdata() async {
    //submit data to server
    final isSuccess = await TodoService.createTodo(body);

    //show success or fail message based on status
    if (isSuccess) {
      titlecontroller.text = '';
      descriptioncontroller.text = '';
      showsuccessmessage(context, message: 'Creation success');
    } else {
      showErrorMessage(context, message: 'creation failed');
    }
  }

  Map get body {
    //get the data from

    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    return {
      "title": title,
      "description": description,
      "is_complete": false,
    };
  }
}



