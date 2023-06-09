import 'package:flutter/material.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/messages_m.dart';
import 'package:intellitalk/src/data/models/user_m.dart';

class TranscriptScreen extends StatefulWidget {
  VoidCallback onBackPressed;
  String selectedId;
  TranscriptScreen(
      {super.key, required this.onBackPressed, required this.selectedId});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  bool isLoadingPage = true;
  final be = Backend();
  Messages? messages;
  User? user;
  @override
  void initState() {
    super.initState();
    asyncFunction();
  }

  void asyncFunction() async {
    messages = await be.fetchDetailConversationById(widget.selectedId);
    if (messages != null) {
      user = await be.fetchDataUser(messages!.userId);
      if (user != null) {
        setState(() {
          isLoadingPage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
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
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Name :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(user!.name)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Email :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(user!.email)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Division :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(user!.division)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Position :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(user!.position)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'User Requirement :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(user!.skill)
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
