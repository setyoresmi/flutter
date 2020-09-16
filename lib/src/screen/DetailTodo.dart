import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/bloc/TodoBloc.dart';
import 'package:simple_todo_app/src/model/DetailTodoModels.dart';

class DetailTodo extends StatefulWidget {
  final String id;
  DetailTodo(this.id, {Key key}): super(key: key);

  @override
  DetailTodoState createState() => DetailTodoState();
}

class DetailTodoState extends State<DetailTodo> {
  final TodoBloc todoBloc = new TodoBloc();
  @override
  void initState() {
    todoBloc.getId(widget.id);
    todoBloc.fetchTodoById();
    super.initState();
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Todo'),
      ),
      body: StreamBuilder(
        stream : todoBloc.todoById,
          builder: (context, AsyncSnapshot<DetailTodoModels> snapshot){
            if(snapshot.hasData){
              return buildText(snapshot,context);
            }else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
  @override
  Widget buildText(AsyncSnapshot<DetailTodoModels> snapshot,BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data.data.title),
                Spacer(),
                if (snapshot.data.data.completed)
                  Text('Completed', style: TextStyle(color: Colors.green)),
                if(!snapshot.data.data.completed)
                  Text('Not Completed', style: TextStyle(color: Colors.red)),
              ],
            ),
          ],
        ),
      );
  }
}