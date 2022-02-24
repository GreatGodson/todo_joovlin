import 'package:flutter/material.dart';
import 'package:todo_joovlin/screens/create_task_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_joovlin/components/constatnts.dart';
import 'package:todo_joovlin/screens/edit_task_screen.dart';
import 'package:todo_joovlin/response/response.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:developer';

class SplashScreen extends StatefulWidget {
  final String taskId;
  static const String id = 'splash_screen';
  const SplashScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, String> queryVariables = {
    "developer_id": developerId,
  };

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  bool isCompleted = false;
  List taskList = [];

  @override
  Widget build(BuildContext context) {
    return Query(
        options:
            QueryOptions(document: gql(getTasks), variables: queryVariables),
        builder: (QueryResult result, {fetchMore, refetch}) {
          // checks if request is successful
          if (result.hasException) {
            //if not successful, show the exception
            return Scaffold(body: Text(result.exception.toString()));
          }
          if (result.isLoading) {
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: Color.fromRGBO(116, 45, 221, 1),
              )),
            );
          }

          // if successful, pass the returned tasks to a list of taskList
          taskList = result.data!['tasks']
              .map((product) => MyTask.fromJson(product))
              .cast<MyTask>()
              .toList();

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
              onPressed: () async {
                var data =
                    await Navigator.pushNamed(context, CreateTaskScreen.id);
                // if (data ?? false) {
                // taskList.insert(0, data);
                refetch!();
                log("$data");
                // setState(() {});
                // }
              },
            ),
            body:
                //checks if the taskList  is empty, ask user to add a taskif it's empty, else returns widget if list
                taskList.isNotEmpty
                    ? ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, UpdateTaskScreen.id);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: CircleAvatar(
                                        radius: 24.0,
                                        backgroundColor: const Color.fromRGBO(
                                            237, 178, 0, 1),
                                        child: CircleAvatar(
                                          radius: 22.0,
                                          backgroundColor: const Color.fromRGBO(
                                              255, 249, 231, 1),
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    237, 178, 0, 1),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Helvetica'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            taskList[index].title,
                                            style: const TextStyle(
                                                color:
                                                    Color.fromRGBO(6, 5, 27, 1),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Helvetica'),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Text(
                                            taskList[index].description,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    167, 166, 180, 1),
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      child: Checkbox(
                                          value: taskList[index].isCompleted,
                                          activeColor: Colors.green,
                                          onChanged: (value) {
                                            setState(() {
                                              print(value);
                                              taskList[index].isCompleted =
                                                  !taskList[index].isCompleted;
                                            });
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          );
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Todo List is empty',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'CircularStd'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Create a task',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(119, 119, 119, 1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'CircularStd'),
                              ),
                            ],
                          )
                        ],
                      ),
          );
        });
  }
}
