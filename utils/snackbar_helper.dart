import 'package:flutter/material.dart';
void showErrorMessage(BuildContext context,{required String message}){
  final snackbar = SnackBar(content: Text(message,
    style: const TextStyle(color: Colors.white),),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
void showsuccessmessage(BuildContext context,{required String message}){
  final snackbar = SnackBar(content: Text(message,
    style: const TextStyle(color: Colors.white),),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
