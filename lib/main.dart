import 'package:flutter/material.dart';
import 'package:to_do_list_app/screens/todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Lİst',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ToDoListScreen(),
    );
  }
}
