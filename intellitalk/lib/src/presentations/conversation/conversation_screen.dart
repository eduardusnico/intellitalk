import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/user_m.dart';

class ChatScreen extends StatefulWidget {
  final String convoId;

  const ChatScreen({super.key, required this.convoId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final be = Backend();

  @override
  void initState() {
    super.initState();
    asynFuct();
  }

  void asynFuct() async {
    user = await be.fetchDataUser(widget.convoId);
    if (user != null) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _chatController =
      TextEditingController(text: 'Saya siap');
  bool isLoadingPage = true;
  bool firstTry = true;
  bool isLoadingResponse = false;
  bool isInterviewEnded = false;
  List<String> conversations = [];
  List<OpenAIChatCompletionChoiceMessageModel> recentMessage = [];
  User? user;

  void askGpt(String question) async {
    setState(() {
      conversations.add(_chatController.text);
      _chatController.clear();
      isLoadingResponse = true;
    });
    if (firstTry == true) {
      recentMessage.add(
        OpenAIChatCompletionChoiceMessageModel(
          content:
              "You are an interviewer from a company named Arkademi. You are doing an interview with the candidate. Make this interview like a conversation, ask only one question per respond. Don't give any information or answer about your question. Please ask ${user!.quantity} question about ${user!.position}. and make sure I understand ${user!.skill}. /'question/' that I mean is the total topic, not the total response. Please ask more question about that topic if you think my answer is not good enough, unless I choose to skip or don't know the answer you can jump to next question. if you have finished asking according to the number of questions I gave to you, you can finish it with /'Terima kasih sudah mengikuti sesi interview ini/'. Make sure you're not using english. Make sure I'm special than other candidates. Here's some data about Arkademi SEO Officer at Arkademi have 0 member, Flutter has 3 member. working culture at arkademi is BRAVE (Bold, Resilience, Autonomous, Velocity, and Empathy).",
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
      if (conversations.last
          .toLowerCase()
          .contains('terima kasih sudah mengikuti sesi interview ini')) {
        isInterviewEnded = true;
      }
      isLoadingResponse = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingPage == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[400]),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 10),
                        child: Text(
                          'Halo ${user!.name} selamat datang di interview arkademi!, sekarang kita akan mulai interview, ketik "Saya siap" jika kamu sudah siap',
                          textAlign: TextAlign.left,
                          maxLines: 4,
                        ),
                      ),
                      for (int i = 0; i < conversations.length; i++)
                        Row(
                          children: [
                            i % 2 == 0 ? const Spacer() : const SizedBox(),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: i % 2 == 0
                                    ? Colors.blue[600]
                                    : Colors.grey[400],
                              ),
                              child: Text(
                                conversations[i],
                                style: TextStyle(
                                    color: i % 2 == 0
                                        ? Colors.white
                                        : Colors.black),
                                maxLines: 10,
                                textAlign: i % 2 == 0
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      isLoadingResponse == true
                          ? const SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator())
                          : const SizedBox(),
                    ]),
              ),
            ),
      bottomNavigationBar: isInterviewEnded == true
          ? const Text('Terima kasih')
          : Container(
              color: Colors.blue[700],
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _chatController,
                          onFieldSubmitted: (value) {
                            askGpt(_chatController.text);
                          },
                          validator: (value) {
                            if (value == null) {
                              return '* Kamu belum mengetik apapun';
                            } else if (value.isEmpty) {
                              return '* Kamu belum mengetik apapun';
                            } else if (value.toLowerCase() !=
                                    'Saya siap'.toLowerCase() &&
                                firstTry == true) {
                              return '* Katakan saya siap terlebih dahulu';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        if (_formKey.currentState!.validate() == true) {
                          askGpt(_chatController.text);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Icon(
                          Icons.keyboard_return,
                          color: Colors.black45,
                        ),
                      )),
                  const SizedBox(width: 20)
                ],
              ),
            ),
    );
  }
}