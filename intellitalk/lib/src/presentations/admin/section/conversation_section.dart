import 'package:flutter/material.dart';
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/user_m.dart';
import 'package:intellitalk/src/presentations/transcript/transcript_screen.dart';

class ConversationSection extends StatefulWidget {
  const ConversationSection({
    super.key,
  });
  @override
  State<ConversationSection> createState() => _ConversationSectionState();
}

class _ConversationSectionState extends State<ConversationSection> {
  static const List<String> tableTitle = [
    'No',
    'Nama',
    'Divisi',
    'Posisi',
    'User Requirement',
    'Transkrip Text'
  ];

  //
  bool isLoadingPage = true;
  bool seeDetail = false;
  String selectedId = '';
  List<User>? listAllUsers;

  //
  final backend = Backend();

  @override
  void initState() {
    super.initState();
    asyncFunction();
  }

  void asyncFunction() async {
    listAllUsers = await backend.fetchUserDoneInterview();
    if (listAllUsers != null) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? const Center(child: CircularProgressIndicator())
        : isLoadingPage == false && seeDetail == true
            ? TranscriptScreen(
                selectedId: selectedId,
                onBackPressed: () {
                  setState(() {
                    seeDetail = false;
                  });
                },
              )
            : Container(
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
                      const Text(
                        'Conversation',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: kSecondaryBlue.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            for (int i = 0; i < tableTitle.length; i++)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                width: i == 0
                                    ? 70
                                    : i == 1
                                        ? 170
                                        : i == 2
                                            ? 150
                                            : i == 3
                                                ? 200
                                                : i == 4
                                                    ? 330
                                                    : null,
                                child: Text(
                                  tableTitle[i],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kGrey3,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      listAllUsers!.isEmpty
                          ? const Text('belum ada kandidat')
                          : Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        (listAllUsers!.length > 6
                                            ? 6
                                            : listAllUsers!.length);
                                    i++)
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9)),
                                    margin: const EdgeInsets.only(bottom: 18),
                                    elevation: 2,
                                    child: Row(children: [
                                      Container(
                                        width: 70,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: Text(
                                          '${i + 1}.',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                          width: 170,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Text(
                                            listAllUsers![i].name,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )),
                                      Container(
                                          width: 150,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Text(
                                            listAllUsers![i].division,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )),
                                      Container(
                                          width: 200,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Text(
                                            listAllUsers![i].position,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                            child: Text(
                                              listAllUsers![i].skill,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                      Container(
                                        width: 150,
                                        padding: const EdgeInsets.only(
                                            top: 14, bottom: 14, right: 20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kPrimaryBlue),
                                          onPressed: () {
                                            setState(() {
                                              seeDetail = true;
                                            });
                                            selectedId = listAllUsers![i].id;
                                          },
                                          child: const Text(
                                            'Detail',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: kWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )
                              ],
                            ),
                    ]),
              );
  }
}
