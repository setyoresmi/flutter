import 'package:dio/dio.dart';
import 'package:simple_todo_app/src/model/DetailTodoModels.dart';
import 'package:simple_todo_app/src/model/TodoModels.dart';

class TodoApiProvider{
  final Dio dio = Dio();
  final url = "https://api-mytodo.herokuapp.com/api/v1/";

  Future<TodoModels> fetchTodoList() async {
   try {
     Response response = await dio.get(url+"todo/list");
     return TodoModels.fromJson(response.data);
    }catch (e) {
      throw Exception('No Data Found '+e.toString());
    }
  }

  Future<DetailTodoModels> fetchTodoById(id) async {
    try {
      Response response = await dio.get(url+"todo/show/$id");
      return DetailTodoModels.fromJson(response.data);
    }catch (e) {
      throw Exception('No Data Found '+e.toString());
    }
  }

  Future addTodo(todoTitle) async {
    try {
      Response response = await dio.post(url+"todo/add",
          data:
            {
              "title": todoTitle
            });
      return response;
    }catch (e) {
      throw Exception('Failed to add data '+e.toString());
    }
  }

  Future updateTodo(id,todoTitle,todoStatus) async {
    try{
      if(todoStatus=="false"){
        todoStatus=1;
      }else{
        todoStatus=0;
      }
      Response response = await dio.put(url+"todo/update/$id",
          data:
            {
              "title": todoTitle,
              "completed": todoStatus
            }
          );
      return response;
    }catch (e){
      throw Exception('Failed to update data '+e.toString());
    }
  }

  Future deleteTodo(id) async{
    try{
      Response response = await dio.delete(url+"todo/delete/$id");
      return response;
    }catch (e){
      throw Exception('Failed to delete data');
    }
  }
}
