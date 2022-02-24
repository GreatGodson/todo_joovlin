import 'package:flutter/material.dart';
import 'package:todo_joovlin/components/components.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_joovlin/components/constatnts.dart';
import 'package:todo_joovlin/main.dart';
import 'dart:convert';
import 'splash_screen.dart';
import 'package:todo_joovlin/response/response.dart';
import 'splash_screen.dart';

class CreateTaskScreen extends StatefulWidget {
  static const String id = 'create_task_screen';

  const CreateTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  Map<String, String> queryVariables = {
    "developer_id": developerId,
  };

  String taskTitle = ' ';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text(
                'Create Task',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'CircularStd'),
              ),
            ],
          ),
        ),
        body: Mutation(
            options: MutationOptions(
                document: gql(addTasks),
                onCompleted: (_) {
                  Navigator.pop(context, true);
                }),
            builder: (RunMutation insert, QueryResult? result) {
              if (result!.hasException) {
                return const Text('exceprtion');
              }
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 31.0, left: 16.0, bottom: 8.0),
                    child: Row(
                      children: const [
                        Text(
                          'Title',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Helvetica',
                              fontSize: 16.0,
                              color: Color.fromRGBO(6, 5, 27, 1)),
                        ),
                      ],
                    ),
                  ),
                  TextFieldWidget(
                      width: 360.0,
                      height: 50.0,
                      hintText: 'What do you want to do?',
                      onChanged: (val) {
                        taskTitle = val;
                      }),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 31.0, left: 16.0, bottom: 8.0),
                    child: Row(
                      children: const [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Helvetica',
                              fontSize: 16.0,
                              color: Color.fromRGBO(6, 5, 27, 1)),
                        ),
                      ],
                    ),
                  ),
                  TextFieldWidget(
                      width: 360.0,
                      height: 100.0,
                      hintText: 'Describe your task',
                      onChanged: (val) {
                        description = val;
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.024),
                  Container(
                    width: 328.0,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(116, 45, 221, 1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: TextButton(
                        onPressed: () {
                          Map<String, String> variables = {
                            "developer_id": developerId,
                            "title": taskTitle,
                            "description": description
                          };
                          insert(variables);

                          //
                          // final taskList = result.data?['tasks']
                          //     .map((product) => MyTask.fromJson(product))
                          //     .cast<MyTask>()
                          //     .toList();

                          //taskList.add(taskTitle, description);

                          // print('create');

                          // createTask();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        )),
                  ),
                ],
              );
            }));
  }
}
