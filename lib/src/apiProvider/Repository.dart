import 'package:simple_todo_app/src/apiProvider/TodoApiProvider.dart';
import 'package:simple_todo_app/src/model/DetailTodoModels.dart';
import 'package:simple_todo_app/src/model/TodoModels.dart';

class Repository{
  final todoApiProvider = TodoApiProvider();

  Future<TodoModels> fetchAllTodo() => todoApiProvider.fetchTodoList();
  Future<DetailTodoModels> fetchTodoById(String id) => todoApiProvider.fetchTodoById(id);
  Future addTodo(String todoTitle) => todoApiProvider.addTodo(todoTitle);
  Future updateTodo(String id,String todoTitle,String todoStatus) => todoApiProvider.updateTodo(id,todoTitle,todoStatus);
  Future deleteTodo(String id) => todoApiProvider.deleteTodo(id);

}