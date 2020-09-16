import 'dart:convert';

DetailTodoModels todoFromJson(String str) => DetailTodoModels.fromJson(json.decode(str));

String todoToJson(DetailTodoModels data) => json.encode(data.toJson());

class DetailTodoModels {
  DetailTodoModels({
    this.data,
    this.status,
  });

  Data data;
  int status;

  factory DetailTodoModels.fromJson(Map<String, dynamic> json) => DetailTodoModels(
    data: Data.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
  };
}

class Data {
  Data({
    this.id,
    this.title,
    this.completed,
  });

  int id;
  String title;
  bool completed;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "completed": completed,
  };
}