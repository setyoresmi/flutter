import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/bloc/TodoBloc.dart';
import 'package:simple_todo_app/src/model/TodoModels.dart';
import 'package:simple_todo_app/src/screen/DetailTodo.dart';

import 'EditTodo.dart';

class TodoList extends StatefulWidget{
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList>{
  final TodoBloc todoBloc = new TodoBloc();
  @override
  void initState() {
    todoBloc.fetchAllTodo();
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
        title: Text('Todo List'),
     ),
     body: StreamBuilder(
        stream : todoBloc.allTodo,
        builder: (context, AsyncSnapshot<TodoModels> snapshot){
          if(snapshot.hasData){
            return buildListView(snapshot);
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator(),);
        }
     ),
    );
  }

  Widget buildListView(AsyncSnapshot<TodoModels> snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Text(snapshot.data.data[index].title),
                       ],
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text("Are you sure want to delete todo ${snapshot.data.data[index].title}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          todoBloc.getId(snapshot.data.data[index].id.toString());
                                          todoBloc.deleteTodo();
                                          Navigator.pop(context);
                                          Future.delayed(Duration(milliseconds: 500), () {
                                            if (!snapshot.data.data[index].updated) {
                                              Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Todo ${snapshot.data.data[index].title} successfully deleted.")));
                                              todoBloc.fetchAllTodo();
                                            }else{
                                              Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Delete data failed.")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => EditTodo(snapshot.data.data[index].title,snapshot.data.data[index].id.toString(),snapshot.data.data[index].completed.toString())));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => DetailTodo(snapshot.data.data[index].id.toString())));
                          },
                          child: Text(
                              "Details"
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          );
        },
        itemCount: snapshot.data.data.length,
      ),
    );
  }
}
