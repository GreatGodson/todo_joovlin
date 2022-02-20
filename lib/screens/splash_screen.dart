import 'package:flutter/material.dart';
import 'package:todo_joovlin/screens/create_task_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      body: Column(
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
  }
}
