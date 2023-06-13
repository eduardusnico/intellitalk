import 'package:dart_openai/openai.dart';
// import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/user_m.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ChatScreen extends StatefulWidget {
  final String convoId;
  // final html.MediaRecorder recorder;

  const ChatScreen({
    super.key,
    required this.convoId,
    // required this.recorder,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final be = Backend();
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
  final ScrollController _chatScrollController = ScrollController();
  // late html.MediaRecorder mediaRecorder;

  @override
  void initState() {
    super.initState();
    asynFuct();
  }

  @override
  void dispose() {
    super.dispose();
    // widget.recorder.stop();
  }

  void asynFuct() async {
    user = await be.fetchDataUser(widget.convoId);
    if (user != null) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  // void checkIsFinish() {
  //   if (user?.status == 1) {
  //     widget.recorder.stop();
  //   }
  //   mediaRecorder = widget.recorder;
  // }

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
              "You are an interviewer from a company named Arkademi. You are doing an interview with the candidate. Candidate name is ${user!.name}. Make this interview like a conversation, ask only one question per respond. Don't give any information or answer about your question. Don't answer out of topic question from the candidate. Please ask ${user!.quantity} question about ${user!.position}. and make sure the candidate understand ${user!.skill}. /'question/' that I mean is the total topic, not the total response. Please ask more question about that topic if you think candidate answer is not good enough, unless the candidate choose to skip or doesn't know the answer you can jump to the next question. if you have finished asking according to the number of questions I gave to you, you can finish it with /'Terima kasih sudah mengikuti sesi interview ini/'. Make sure you're not using english. Make sure I'm special than other candidates. Here's some data about Arkademi: 1. Working culture at Arkademi is BRAVE (Bold, Resilience, Autonomous, Velocity, Empathy), 2. Working hour from 9 AM to 6 PM, 3. full WFO, 4. The office location is at Jalan Mars Raya no. 15, Vila Cinere Mas, Cinere. 6. Info about current member on the position (CEO 1 member (Hilman Fajrian), Secretary 1 member, Head of Operation 1 member, Business Development manager 1 member, Product Manager 1 member, Finance Manager 1 member, Social Media Specialist 2 member, UI/UX Artist 1 member, UX Researcher 1 member, UI Designer 2 member, UX Writer 1 member, Mobile Engineer 3 member, Multimedia deputy manager 1 member, Tax accountant 2 member, Tech Manager 1 member, Tech deputy manager 1 member, Flutter Developer 3 member, Frontend Developer 4 member, Backend 3 member, Technical Writer 1 member, Developer Operation 1 member, System Admin 2 member, Academic Manager 1 member, Marketing Communication 2 member, Quality Assurance 1 member, Graphic Designer 3 member, Account Executive 5 member, Customer Relation 4 member, Learning Analyst 3 member, Learning deputy manager 1 member,  General Affair 3 member, Learning Operation 7 member, SEO Specialist 3 member, Customer Retention Lead 1 member, System Analyst 1 member, Public Relation 2 member, Instructional Designer 4 member, Office Operation Admin 1 member, Compensation and Benefit 1 member, Lead Office Operation 1 member, Data Administration 1 member, Accountant 2 member, Training and Development 1 member, People Analytic 1 member, Junior Account Executive 1 member, Senior Executive Manager 1 member, Legal and Compliance 1 member, Social Media Designer 1 member, Partnership Representative 3 member, Partnership Scout 7 member, Talent Acquisition 3 member, Video Operator 2 member, Sales Operation 1 member, Zoom Operation 24 member)",
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
          .contains('terima kasih sudah mengikuti')) {
        isInterviewEnded = true;
        be
            .postConversation(conversations, user!.name, user!.id)
            .then((value) => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.symmetric(
                            vertical: 28, horizontal: 38),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Thank You",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'We will let you know when the results are out',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.5, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ));
                }));
      }

      isLoadingResponse = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: kPrimaryBlue,
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'INTELLITALK INTERVIEW',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${user?.position ?? ''} - ${user?.division.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: kWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.31,
                ),
                isLoadingPage == true
                    ? const SizedBox(
                        width: 0,
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 40),
                        child: isInterviewEnded == true || user!.status == 1
                            ? const SizedBox(
                                width: 90,
                              )
                            : SlideCountdownSeparated(
                                textStyle: const TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                                decoration: const BoxDecoration(),
                                separatorStyle: const TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                                onDone: () async {
                                  setState(() {
                                    isInterviewEnded = true;
                                  });
                                  be
                                      .postConversation(
                                          conversations, user!.name, user!.id)
                                      .then((value) => showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 28,
                                                      horizontal: 38),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Text(
                                                        "Time's Up!",
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        'Thank you for participating on this interview!',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          }));
                                },
                                duration: Duration(minutes: user!.quantity * 3),
                              ),
                      )
              ],
            ),
          )),
      body: isLoadingPage == true
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : user!.status == 1
              ? const Center(
                  child: Text(
                  "Sesi interview sudah berakhir.\n\nHarap periksa email anda secara berkala untuk mengetahui hasil interview ini\nTerima Kasih",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                ))
              : SingleChildScrollView(
                  controller: _chatScrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.5),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: kGrey2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Arkademi',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryBlue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'Halo ${user!.name} selamat datang di interview arkademi! sekarang kita akan mulai interview, ketik "Saya siap" jika kamu sudah siap',
                                    textAlign: TextAlign.left,
                                    maxLines: 4,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: kBlack,
                                    )),
                              ],
                            ),
                          ),
                          for (int i = 0; i < conversations.length; i++)
                            Row(
                              children: [
                                i % 2 == 0 ? const Spacer() : const SizedBox(),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: i % 2 == 0 ? kSecondaryBlue : kGrey2,
                                  ),
                                  child: i % 2 == 0
                                      ? Text(
                                          conversations[i],
                                          style: TextStyle(
                                              color:
                                                  i % 2 == 0 ? kWhite : kBlack),
                                          maxLines: 10,
                                          textAlign: i % 2 == 0
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Arkademi',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: kPrimaryBlue),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              conversations[i],
                                              style: const TextStyle(
                                                  fontSize: 15, color: kBlack),
                                              maxLines: 10,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
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
      bottomNavigationBar: isLoadingPage == true
          ? const SizedBox()
          : (isLoadingPage == false &&
                  (isInterviewEnded == true || user!.status == 1))
              ? const SizedBox()
              : Container(
                  color: kPrimaryBlue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _chatController,
                              onFieldSubmitted: (value) {
                                if (_formKey.currentState!.validate() == true) {
                                  askGpt(_chatController.text);
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Kamu belum mengetik apapun';
                                } else if (value.toLowerCase() !=
                                        'Saya siap'.toLowerCase() &&
                                    firstTry == true) {
                                  return '* Katakan saya siap terlebih dahulu';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Ketik Pesan',
                                errorStyle:
                                    const TextStyle(color: Colors.white),
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
                      // const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate() == true) {
                            askGpt(_chatController.text);
                          }
                        },
                        child: const Icon(Icons.send_rounded,
                            size: 44, color: kSecondaryBlue),
                      ),
                      const SizedBox(width: 20)
                    ],
                  ),
                ),
    );
  }
}
