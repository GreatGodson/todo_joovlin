import 'package:flutter/material.dart';
import 'package:todo_joovlin/components/components.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const addTasks = """
  mutation InsertTask(\$description: String!, \$developer_id: String!, \$title: String!) {
  insert_tasks_one(object: {title: \$title, developer_id: \$developer_id, description: \$description}) {
    created_at
    description
    developer_id
    id
    isCompleted
    title
    updated_at
  }
}
 
  """;

class CreateTaskScreen extends StatefulWidget {
  static const String id = 'create_task_screen';
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  Map<String, String> variables = {
    "developer_id": "UNIQUE ID FOR YOUR APP",
    "title": "NewMen",
    "description": "DESCRIPTION"
  };

  createTask() async {
    await Query(
        options: QueryOptions(document: gql(addTasks), variables: variables),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print('failed');
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            print('Loading');
            return const Center(child: CircularProgressIndicator());
          }
          print('succesful');
          return const Text('added successful');
        });
  }

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
        body:
            // Query(
            //     options: QueryOptions(document: gql(addTasks), variables: variables),
            //     builder: (QueryResult result, {fetchMore, refetch}) {
            //       if (result.hasException) {
            //         return Text(result.exception.toString());
            //       }
            //       if (result.isLoading) {
            //         return Center(child: CircularProgressIndicator());
            //       }

            // return
            Column(
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
            TextFieldWidget(
                width: 360.0,
                height: 50.0,
                hintText: 'What do you want to do?',
                onChanged: (val) {
                  String task = val;
                }),
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
            TextFieldWidget(
                width: 360.0,
                height: 100.0,
                hintText: 'Describe your task',
                onChanged: (val) {
                  String task = val;
                }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.024),
            Container(
              width: 328.0,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(116, 45, 221, 1),
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextButton(
                  onPressed: () {
                    print('create');
                    createTask();
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
        )
        // }),
        );
  }
}
