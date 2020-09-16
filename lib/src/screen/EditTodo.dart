import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/bloc/TodoBloc.dart';

class EditTodo extends StatefulWidget {
  final String title, id, isCompleted;
  EditTodo(this.title, this.id, this.isCompleted, {Key key}): super(key: key);

  @override
  EditTodoState createState() => EditTodoState();
}

class EditTodoState extends State<EditTodo> {
  final TodoBloc todoBloc = new TodoBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: todoBloc.addTitle,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: "To do",
                  hintText:widget.title
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    todoBloc.getId(widget.id);
                    todoBloc.addTitle;
                    todoBloc.getStatus(widget.isCompleted);
                    todoBloc.updateTodo();
                    Future.delayed(Duration(seconds: 1), () {
                      todoBloc.fetchAllTodo();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

