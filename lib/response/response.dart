// To parse this JSON data, do
//
//     final getTaskService = getTaskServiceFromJson(jsonString);

import 'dart:convert';

MyTask getTaskServiceFromJson(String str) => MyTask.fromJson(json.decode(str));

String getTaskServiceToJson(MyTask data) => json.encode(data.toJson());

class MyTask {
  MyTask({
    required this.id,
    required this.developerId,
    required this.description,
    required this.createdAt,
    required this.isCompleted,
    required this.title,
    required this.updatedAt,
  });

  String id;
  String developerId;
  String description;
  DateTime createdAt;
  bool isCompleted;
  String title;
  DateTime updatedAt;

  factory MyTask.fromJson(Map<String, dynamic> json) => MyTask(
        id: json["id"],
        developerId: json["developer_id"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        isCompleted: json["isCompleted"],
        title: json["title"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "developer_id": developerId,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "isCompleted": isCompleted,
        "title": title,
        "updated_at": updatedAt.toIso8601String(),
      };
}
