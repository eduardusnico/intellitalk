import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/user_m.dart';

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
    'Link Interview'
  ];

  //
  bool isLoadingPage = true;
  List<User>? listUser;
  //
  final backend = Backend();

  @override
  void initState() {
    super.initState();
    asyncFunction();
  }

  void asyncFunction() async {
    listUser = await backend.fetchAllUser();
    if (listUser != null) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? const Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.08,
              bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Conversation',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        width: i == 0
                            ? 70
                            : i == 1
                                ? 170
                                : i == 2
                                    ? 150
                                    : i == 3
                                        ? 200
                                        : 260,
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
              listUser!.isEmpty
                  ? const Text('belum ada kandidat')
                  : Column(
                      children: [
                        for (int i = 0;
                            i < (listUser!.length > 6 ? 6 : listUser!.length);
                            i++)
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9)),
                            margin: const EdgeInsets.only(bottom: 18),
                            elevation: 2,
                            child: Row(children: [
                              Container(
                                width: 70,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Text(
                                  '${i + 1}.',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                  width: 170,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    listUser![i].name,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    listUser![i].division,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  width: 200,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    listUser![i].position,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    context.goNamed('conversation',
                                        pathParameters: {
                                          'convoId': listUser![i].id
                                        });
                                  },
                                  child: Text(
                                    listUser![i].link,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kSecondaryBlue),
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
