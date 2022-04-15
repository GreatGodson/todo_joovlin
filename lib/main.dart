import 'package:flutter/material.dart';
import 'package:todo_joovlin/screens/create_task_screen.dart';
import 'package:todo_joovlin/screens/edit_task_screen.dart';
import 'package:todo_joovlin/screens/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  final HttpLink httpLink = HttpLink(
      "https://todolistassessment.hasura.app/v1/graphql",
      defaultHeaders: <String, String>{
        "x-hasura-admin-secret":
            "JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm",
      });

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  ));

  var app = GraphQLProvider(client: client, child: const MyApp());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Game())],
    child: app,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(116, 45, 221, 1),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(116, 45, 221, 1),
        ),
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: SplashScreen.id,
      // define routes and screens for easy navigation
      routes: {
        SplashScreen.id: (context) => const SplashScreen(
              taskId: "gu",
            ),
        CreateTaskScreen.id: (context) => const CreateTaskScreen(),
        UpdateTaskScreen.id: (context) => const UpdateTaskScreen(),
      },
    );
  }
}
