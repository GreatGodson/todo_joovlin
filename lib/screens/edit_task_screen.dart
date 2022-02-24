import 'package:flutter/material.dart';
import 'package:todo_joovlin/components/components.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:todo_joovlin/components/constatnts.dart';

class UpdateTaskScreen extends StatefulWidget {
  static const String id = 'edit_task_Screen';
  const UpdateTaskScreen({Key? key}) : super(key: key);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  Map<String, String> getSingleTaskVariable = {
    "id": "51c52335-2477-4318-aee8-f35edc0b427b"
  };

  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Mutation(
                options: MutationOptions(document: gql(deleteTaskMutation)),
                builder: (RunMutation insert, QueryResult? result) {
                  if (result!.hasException) {
                    return Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return IconButton(
                      onPressed: () {
                        Map<String, String> deleteVariables = {
                          "id": "c5c85ff6-aa51-4580-94fd-2c379cad8823"
                        };

                        insert(deleteVariables);
                      },
                      icon: const Icon(Icons.delete));
                }),
          ],
          title: Row(
            children: const [
              Text(
                'Task Details',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'CircularStd'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 31.0, left: 16.0, bottom: 8.0),
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
            CustomTextForm(
              width: 360.0,
              height: 50.0,
              onChanged: (val) {
                title = val;
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 31.0, left: 16.0, bottom: 8.0),
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
            CustomTextForm(
              width: 360.0,
              height: 100.0,
              onChanged: (val) {
                description = val;
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.024),
            Container(
              width: 328.0,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(116, 45, 221, 1),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Mutation(
                  options: MutationOptions(document: gql(updateTaskMutation)),
                  builder: (RunMutation insert, QueryResult? result) {
                    if (result!.hasException) {
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return TextButton(
                        onPressed: () {
                          Map<String, dynamic> updateVariables = {
                            "id": "8c163313-9456-49dd-a974-faa1380d1aa2",
                            "payload": {
                              "isCompleted": false,
                              "title": title,
                              "description": description
                            }
                          };
                          insert(updateVariables);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ));
                  }),
            ),
          ],
        )
        // }),
        );
  }
}

class Game with ChangeNotifier {}
