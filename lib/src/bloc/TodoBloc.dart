import 'package:simple_todo_app/src/apiProvider/Repository.dart';
import 'package:simple_todo_app/src/model/DetailTodoModels.dart';
import 'package:simple_todo_app/src/model/TodoModels.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  final repository = Repository();
  final todoFetcher = PublishSubject<TodoModels>();
  final todoByIdFetcher = PublishSubject<DetailTodoModels>();
  final todoTitle = BehaviorSubject<String>();
  final todoId = BehaviorSubject<String>();
  final todoStatus = BehaviorSubject<String>();
  final detailId = BehaviorSubject<String>();

  Stream<TodoModels> get allTodo => todoFetcher.stream;
  Stream<DetailTodoModels> get todoById => todoByIdFetcher.stream;
  Function(String) get addTitle => todoTitle.sink.add;
  Function(String) get getId => todoId.sink.add;
  Function(String) get getStatus => todoStatus.sink.add;

  fetchAllTodo() async {
    TodoModels todo = await repository.fetchAllTodo();
    todoFetcher.sink.add(todo);
  }

  fetchTodoById() async {
    DetailTodoModels todo = await repository.fetchTodoById(todoId.value);
    todoByIdFetcher.sink.add(todo);
  }

  addTodo(){
    repository.addTodo(todoTitle.value);
  }

  updateTodo() {
    repository.updateTodo(todoId.value,todoTitle.value,todoStatus.value);
  }

  deleteTodo(){
    repository.deleteTodo(todoId.value);
  }

  dispose(){
    todoFetcher.close();
    todoByIdFetcher.close();
    todoTitle.close();
    todoId.close();
    todoStatus.close();
  }
}