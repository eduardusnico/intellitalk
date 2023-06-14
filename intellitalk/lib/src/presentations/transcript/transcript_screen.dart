import 'dart:convert';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/messages_m.dart';
import 'package:intellitalk/src/data/models/resp_list_message_m.dart';
import 'package:intellitalk/src/data/models/user_m.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class TranscriptScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  final String selectedId;
  const TranscriptScreen(
      {super.key, required this.onBackPressed, required this.selectedId});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  final be = Backend();
  bool isLoadingPage = true;
  bool isLoadingGpt = true;
  String? feedback;
  Map<String, dynamic>? messageJson;
  Messages? messages;
  User? user;
  @override
  void initState() {
    super.initState();
    asyncFunction();
  }

  Future<void> askFeedbackGpt() async {
    OpenAICompletionModel chatCompletion = await OpenAI.instance.completion.create(
        model: "text-davinci-003",
        temperature: 0,
        frequencyPenalty: 0,
        presencePenalty: 0,
        maxTokens: 1000,
        bestOf: 1,
        topP: 1,
        prompt:
            'Please use Bahasa Indonesia. Please give feedback and summary of this following candidate, and make sure the candidate already has the ability to this position (${user!.position}) and whether he has had the skill (${user!.skill}). Then give a score with a rate from 1-100 to the candidate (please be stingy but wise for giving the score). provide summary and score in the format "Score, Summary".\nthis is the interview transcript text: ${messageJson!["data"]["messages"]}');
    final prefs = await SharedPreferences.getInstance();
    feedback = chatCompletion.choices.first.text;
    await prefs.setString('feedback_${user!.id}', feedback!.trim());
    setState(() {
      isLoadingGpt = false;
    });
  }

  void asyncFunction() async {
    final dataJson = await be.fetchDetailConvoJson(widget.selectedId);
    messageJson = json.decode(dataJson);
    final dataModel = ResponseListMessage.fromJson(dataJson);
    messages = dataModel.listMessage;
    if (messages != null) {
      user = await be.fetchDataUser(messages!.userId);
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        feedback = prefs.getString('feedback_${user!.id}');
        setState(() {
          isLoadingPage = false;
        });
        if (feedback == null) {
          await askFeedbackGpt();
        } else {
          setState(() {
            isLoadingGpt = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? const Expanded(child: Center(child: CircularProgressIndicator()))
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08,
                bottom: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: widget.onBackPressed,
                      child: Image.asset(
                        'images/logo_back.png',
                        height: 35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Conversation Candidate',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Summary by Intellitalk Bot :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(height: 6),
                                  isLoadingGpt == true && feedback == null
                                      ? Shimmer.fromColors(
                                          baseColor: kGrey2,
                                          highlightColor: kGrey1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 18,
                                                color: kGrey2,
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                height: 18,
                                                color: kGrey2,
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                height: 18,
                                                color: kGrey2,
                                              ),
                                              const SizedBox(height: 8),
                                            ],
                                          ))
                                      : Text(
                                          feedback!.trim(),
                                          style: const TextStyle(
                                              height: 1.4,
                                              fontWeight: FontWeight.w500),
                                        ),
                                  const SizedBox(height: 30),
                                  for (int i = 0;
                                      i < messages!.messages.length;
                                      i++)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              messages!.messages[i].sender,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              messages!.messages[i].message,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ]),
                                    )
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/logo_people.png',
                                  height: 30,
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Identity Candidate',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Name : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            user!.name,
                                            maxLines: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Email : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            user!.email,
                                            maxLines: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Division : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            user!.division,
                                            maxLines: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Position :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            user!.position,
                                            maxLines: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'User Requirement :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            user!.skill,
                                            maxLines: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
