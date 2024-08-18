
import 'package:flutter/material.dart';
import 'package:to_do_app/to_dolist.dart';

void main(){
  runApp(   MaterialApp(
    home: const ToDolist(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false));
}