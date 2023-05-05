import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

import 'env/env.dart';

void main() {
  OpenAI.organization = "org-1Kblirv4lYCscoMRWred49nU";
  OpenAI.apiKey = Env.apiKey;
  streamText();
  runApp(const MyApp());
}

// void fetchModelDavinci() async {
//   OpenAIModelModel model =
//       await OpenAI.instance.model.retrieve("text-davinci-003");
//   print(model.id);
// }

void streamText() {
  Stream<OpenAIStreamCompletionModel> completionStream =
      OpenAI.instance.completion.createStream(
    model: "text-davinci-003",
    prompt:
        "You are a YC partner. You are doing a mock interview with me to prepare me for my Y Combinator interview. Play hardball. Ask tough questions about my startup. Make sure I'm making something people want. And that my idea is not a tarpit idea, i.e. an idea that a lot of people",
    maxTokens: 100,
    temperature: 0.5,
    topP: 1,
  );

  completionStream.listen((event) {
    final firstCompletionChoice = event.choices.first;
    print(firstCompletionChoice.text); // ...
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intellitalk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
