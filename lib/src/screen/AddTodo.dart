import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/bloc/TodoBloc.dart';

class AddTodo extends StatefulWidget {
  @override
  AddTodoState createState() => AddTodoState();
}

class AddTodoState extends State<AddTodo> {
  final TodoBloc todoBloc = new TodoBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              onChanged: todoBloc.addTitle,
              maxLines: 2,
              decoration: InputDecoration(
                  hintText: 'Add what do you want to do'),
            ),
            RaisedButton(
              onPressed: () {
                todoBloc.addTodo();
                Future.delayed(Duration(seconds: 1), () {
                  todoBloc.fetchAllTodo();
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}

