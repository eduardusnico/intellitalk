import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/env/env.dart';

import 'src/presentations/admin/admin_screen.dart';
import 'src/presentations/conversation/conversation_screen.dart';

void main() {
  OpenAI.organization = "org-1Kblirv4lYCscoMRWred49nU";
  OpenAI.apiKey = Env.apiKey;
  runApp(const MyApp());
}

// void fetchModelDavinci() async {
//   OpenAIModelModel model =
//       await OpenAI.instance.model.retrieve("text-davinci-003");
//   print(model.id);
// }

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'admin',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AdminScreen();
      },
    ),
    GoRoute(
      name: 'conversation',
      path: '/conversations/:convoId',
      builder: (BuildContext context, GoRouterState state) {
        return ChatScreen(
          convoId: state.pathParameters['convoId']!,
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Intellitalk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("body"),
    );
  }
}
