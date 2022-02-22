import 'package:flutter/material.dart';
import 'package:todo_joovlin/screens/create_task_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';

//const String developer_id = "UNIQUE ID FOR YOUR APP";
const getTasks = """
  query GetAllTasks(\$developer_id: String!) {
  tasks(where: {developer_id: {_eq: \$developer_id}}) {
    id
    developer_id
    description
    created_at
    isCompleted
    title
    updated_at
  }
}
  """;

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // {
  // "developer_id": "UNIQUE ID FOR YOUR APP",
  // }
  int index = 0;
  Map<String, String> variables = {
    "developer_id": "UNIQUE ID FOR YOUR APP",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'Todo List',
              style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, CreateTaskScreen.id);
        },
      ),
      body: Query(
        options: QueryOptions(document: gql(getTasks), variables: variables),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final taskList = result.data!['tasks']
              .map((product) => GetTaskService.fromJson(product))
              .cast<GetTaskService>()
              .toList();
          // List<GetTaskService> listTask = [];
          print(taskList[1].title);
          // print(taskList);

          // listTask = result.data;

          // var fff =
          // print(taskList!['tasks'][0]['isCompleted']);
          //print(taskList);

          return taskList.isNotEmpty
              ? ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Column(children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 22.0,
                            ),
                            Text(
                              taskList[index].title,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ]),
                    );
                  })
              : ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            taskList[index].title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20.0),
                          ),
                        ]);
                  });
        },
      ),
    );
  }
}

class TaskScreen extends StatefulWidget {
  //static const String id = 'splash_screen';
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<GetTaskService> listTask = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: listTask.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    listTask[0].title,
                    style: TextStyle(color: Colors.black),
                  ),
                ]);
          }),
    );
  }
}

// To parse this JSON data, do
//
//     final getTaskService = getTaskServiceFromJson(jsonString);

// import 'dart:convert';

GetTaskService getTaskServiceFromJson(String str) =>
    GetTaskService.fromJson(json.decode(str));

String getTaskServiceToJson(GetTaskService data) => json.encode(data.toJson());

class GetTaskService {
  GetTaskService({
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

  factory GetTaskService.fromJson(Map<String, dynamic> json) => GetTaskService(
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

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Text(
// 'Todo List is empty',
// style: TextStyle(
// fontSize: 24.0,
// color: Color.fromRGBO(0, 0, 0, 1),
// fontWeight: FontWeight.w400,
// fontFamily: 'CircularStd'),
// ),
// ],
// ),
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.01,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Text(
// 'Create a task',
// style: TextStyle(
// fontSize: 18.0,
// color: Color.fromRGBO(119, 119, 119, 1),
// fontWeight: FontWeight.w400,
// fontFamily: 'CircularStd'),
// ),
// ],
// )
// ],
// );
