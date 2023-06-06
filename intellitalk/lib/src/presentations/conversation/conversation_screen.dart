import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String convoId;

  const ChatScreen({super.key, required this.convoId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  bool firstTry = true;
  bool isLoadingResponse = false;
  List<String> conversations = [];
  List<OpenAIChatCompletionChoiceMessageModel> recentMessage = [];

  void askGpt(String question) async {
    setState(() {
      conversations.add(_chatController.text);
      _chatController.clear();
      isLoadingResponse = true;
    });
    if (firstTry == true) {
      recentMessage.add(
        const OpenAIChatCompletionChoiceMessageModel(
          content:
              "You are an interviewer from a company named Arkademi. You are doing an interview with the candidate. Make this interview like a conversation. Don't give any information or answer about your question. Please ask 2 question about SEO Officer. and make sure I understand SEO Google. /'question/' that I mean is the total topic, not the total response. if you have finished asking according to the number of questions I gave to you, you can finish it with closing statement. You can give the information to user, if he ask about Arkademi. SEO Officer at Arkademi have 0 member, Flutter has 3 member. working culture at arkademi is BRAVE (Bold, Resilience, Autonomous, Velocity, and Empathy) /n/nBut before starting this interview there are several conditions, namely: 1. Don't respond anything before the interview start, and after the interview ended. 2. don't start the interview before I said /'Saya siap/' (Indonesian language). 3. You can't respond using english. 4. Make sure I'm special from other candidates. 5. Don't move on to the next question if you feel my answer is still unsatisfactory, unless I choose to skip or don't know the answer. ",
          role: OpenAIChatMessageRole.system,
        ),
      );
      firstTry = false;
    }
    recentMessage.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: question,
        role: OpenAIChatMessageRole.user,
      ),
    );
    List<OpenAIChatCompletionChoiceMessageModel>
        tempCompletionChoiceMessageModel = recentMessage;
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      temperature: 1,
      messages: tempCompletionChoiceMessageModel,
    );
    conversations.add(chatCompletion.choices.last.message.content);
    recentMessage.add(chatCompletion.choices.last.message);
    setState(() {
      isLoadingResponse = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const Text(
              'Halo Bro selamat datang di interview arkademi!, sekarang kita akan mulai interview, ketik saya siap jika kamu sudah siap'),
          for (int i = 0; i < conversations.length; i++) Text(conversations[i]),
          isLoadingResponse == true
              ? const CircularProgressIndicator()
              : const SizedBox(),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _chatController,
                validator: (value) {
                  if (value == null) {
                    return 'Kamu belum mengetik apapun';
                  } else if (value.isEmpty) {
                    return 'Kamu belum mengetik apapun';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )),
              ElevatedButton(
                  onPressed: () {
                    askGpt(_chatController.text);
                  },
                  child: const Text('enter')),
            ],
          )
        ]),
      ),
    );
  }
}
