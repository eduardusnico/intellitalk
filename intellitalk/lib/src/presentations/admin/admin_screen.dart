import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/presentations/admin/section/candidate_section.dart';
import 'package:intellitalk/src/presentations/admin/section/conversation_section.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final backend = Backend();
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: kPrimaryBlue,
            width: MediaQuery.of(context).size.width * 0.2,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Column(children: [
              Image.asset(
                '/images/logo_arkademi_white.png',
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    indexSelected = 0;
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      '/images/logo_home.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'My Dashboard',
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: indexSelected == 0
                              ? FontWeight.bold
                              : FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    indexSelected = 1;
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      '/images/logo_conversation.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'Conversation',
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: indexSelected == 1
                              ? FontWeight.bold
                              : FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  context.pushReplacementNamed('login');
                },
                child: Row(
                  children: [
                    Image.asset(
                      '/images/logo_logout.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Logout',
                      style:
                          TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ]),
          ),
          indexSelected == 0
              ? const CandidateSection()
              : const ConversationSection()
        ],
      ),
    );
  }
}
