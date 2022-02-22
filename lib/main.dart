import 'package:flutter/material.dart';
import 'package:todo_joovlin/screens/create_task_screen.dart';
import 'package:todo_joovlin/screens/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  final HttpLink httpLink = HttpLink(
      "https://todolistassessment.hasura.app/v1/graphql",
      defaultHeaders: <String, String>{
        "x-hasura-admin-secret":
            "JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm",
      });

  // const Bearer =
  //     "JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm";
  // String AuthLink = "$Bearer $httpLink";
  // String apiToken =
  //     "JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm";
  // Map<String, String> get headers => {
  //   'Authorization': 'Bearer $apiToken',
  // 'Content-Type': 'application/json',
  // };

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  ));

  // Map<String, String> get headers => {
  //   'Authorization': 'Bearer $apiToken',
  // 'Content-Type': 'application/json',
  // };
  //
  // client. apiToken = {
  //   "Authorization": "Bearer <JWT_TOKEM>",
  //   "Another_Header_Key": "Another Header Value"
  // }
  //client.apiToken = '<>';

  var app = GraphQLProvider(client: client, child: const MyApp());
  runApp(app);
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
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        CreateTaskScreen.id: (context) => const CreateTaskScreen(),
      },
    );
  }
}
