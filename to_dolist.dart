import 'dart:convert';
import 'package:to_do_app/widget/Todo_card.dart';

import 'utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/add-page.dart';
import 'package:to_do_app/services/todo_service.dart';
 class ToDolist extends StatefulWidget {
   const ToDolist({super.key});
 
   @override
   State<ToDolist> createState() => _ToDolistState();
 }
 
 class _ToDolistState extends State<ToDolist> {
   bool isloading = true;
   List items = [];

   @override
   void initState() {
     super.initState();
     fetchTodo();
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Todo list',),
         centerTitle: true,
         backgroundColor: Colors.blueGrey,

       ),
       body: Visibility(
         visible: isloading,
         child: Center(child: CircularProgressIndicator()),
         replacement: RefreshIndicator(
           onRefresh: fetchTodo,
           child: Visibility(
             visible: items.isNotEmpty,
             replacement: const Center(
               child: Text('No todo item',
                 style: TextStyle(
                   fontSize: 40,
                   letterSpacing: 2.0,
                 ),
               ),

             ),
             child: ListView.builder(
                 itemCount: items.length,
                 padding: EdgeInsets.all(20),
                 itemBuilder: (context, index) {
                   final item = items[index] as Map;
                   final id = item['_id'] as String;
                   return TodoCard(
                     index: index,
                     deleteById: deleteById,
                     navigateEdit: navigatetoEditpage,
                     item: item,
                   );
                 }),


           ),
         ),
       ),
       floatingActionButton: FloatingActionButton.extended(
           onPressed: navigatetoAddpage
           , label: Text('Add Todo')),
     );
   }



     Future<void> navigatetoEditpage(Map item) async {
       final route = MaterialPageRoute(
         builder: (context) => Addpage(todo: item),
       );
       await Navigator.push(context, route);
       setState(() {
         isloading = true;
       });
       fetchTodo();
     }
     void navigatetoAddpage() async {
       final route = MaterialPageRoute(builder: (context) => const Addpage(),
       );
       await Navigator.push(context, route);
       setState(() {
         isloading = true;
       });
       fetchTodo();
     }
     Future<void> deleteById(String id) async {
       final isSuccess = await TodoService.deleteById(id);
       //Remove the item from the list
       if (isSuccess) {
         final filtered = items.where((element) => element['_id'] != id)
             .toList();
         setState(() {
           items = filtered;
         });
       }
       else {
         showErrorMessage(context, message: 'Deletion failed');
       }
     }
     Future<void> fetchTodo() async {
       final response = await TodoService.fetchTodos();
       if (response != null) {
         setState(() {
           items = response;
         });
       } else {
         showErrorMessage(context, message: 'Something went wrong');
       }
       setState(() {
         isloading = false;
       });
     }
   }

