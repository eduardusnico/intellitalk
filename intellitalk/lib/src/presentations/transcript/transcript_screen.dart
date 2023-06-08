import 'package:flutter/material.dart';

class TranscriptScreen extends StatefulWidget {
  VoidCallback onBackPressed;
  TranscriptScreen({super.key, required this.onBackPressed});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            const SizedBox(height: 30),
                            for (int i = 0; i < 100; i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Naufal :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "- kamu nanyea",
                                        style: TextStyle(
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
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                              for (int i = 0; i < 5; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Name :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text('Naufal Hakim')
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
