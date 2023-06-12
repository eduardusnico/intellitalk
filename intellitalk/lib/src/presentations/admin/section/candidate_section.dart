import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/constants.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/user_m.dart';

class CandidateSection extends StatefulWidget {
  const CandidateSection({
    super.key,
  });
  @override
  State<CandidateSection> createState() => _CandidateSectionState();
}

class _CandidateSectionState extends State<CandidateSection> {
  static const List<String> tableTitle = [
    'No',
    'Nama',
    'Divisi',
    'Posisi',
    'Link Interview'
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTxt = TextEditingController();
  final TextEditingController _divisionTxt = TextEditingController();
  final TextEditingController _positionTxt = TextEditingController();
  final TextEditingController _skillTxt = TextEditingController();
  final TextEditingController _quantityTxt = TextEditingController();
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

  void clearTextController() {
    _nameTxt.clear();
    _positionTxt.clear();
    _divisionTxt.clear();
    _quantityTxt.clear();
    _skillTxt.clear();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? const Expanded(child: Center(child: CircularProgressIndicator()))
        : Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.08,
              bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Candidate',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 28, horizontal: 38),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Add New Candidate',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          'Fill the form below to add new candidate',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Name',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _nameTxt,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Tidak boleh kosong';
                                                } else if (value.isEmpty) {
                                                  return 'Tidak boleh kosong';
                                                }
                                                return null;
                                              },
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: kGrey1
                                                          .withOpacity(0.2)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 14),
                                            // const Text(
                                            //   'Email',
                                            //   style: TextStyle(fontSize: 12),
                                            // ),
                                            // const SizedBox(height: 5),
                                            // TextFormField(controller: ,
                                            //   style: const TextStyle(fontSize: 12),
                                            //   decoration: InputDecoration(
                                            //     isDense: true,
                                            //     border: OutlineInputBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(10),
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(height: 14),
                                            const Text(
                                              'Division',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _divisionTxt,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Tidak boleh kosong';
                                                } else if (value.isEmpty) {
                                                  return 'Tidak boleh kosong';
                                                }
                                                return null;
                                              },
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 14),
                                            const Text(
                                              'Position',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _positionTxt,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Tidak boleh kosong';
                                                } else if (value.isEmpty) {
                                                  return 'Tidak boleh kosong';
                                                }
                                                return null;
                                              },
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 14),
                                            const Text(
                                              'User Requirement',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _skillTxt,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Tidak boleh kosong';
                                                } else if (value.isEmpty) {
                                                  return 'Tidak boleh kosong';
                                                }
                                                return null;
                                              },
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 14),
                                            const Text(
                                              'Total Question Asked (minimal)',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: _quantityTxt,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Tidak boleh kosong';
                                                } else if (value.isEmpty) {
                                                  return 'Tidak boleh kosong';
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return 'Harap masukkan hanya angka';
                                                }
                                                return null;
                                              },
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 44),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 24,
                                                          horizontal: 34),
                                                      backgroundColor: kGrey2),
                                                  onPressed: () {
                                                    clearTextController();
                                                    context.pop();
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: kGrey3,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 24,
                                                          horizontal: 34),
                                                      backgroundColor:
                                                          kPrimaryBlue),
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                            .validate() ==
                                                        true) {
                                                      final successAddCandidate =
                                                          await backend
                                                              .addNewCandidate(
                                                                  _nameTxt.text,
                                                                  Random()
                                                                      .nextInt(
                                                                          10000)
                                                                      .toString(),
                                                                  _divisionTxt
                                                                      .text,
                                                                  _positionTxt
                                                                      .text,
                                                                  _skillTxt
                                                                      .text,
                                                                  int.parse(
                                                                      _quantityTxt
                                                                          .text));
                                                      if (successAddCandidate ==
                                                          true) {
                                                        clearTextController();
                                                        context.pop();
                                                        setState(() {
                                                          isLoadingPage = true;
                                                        });

                                                        listUser = await backend
                                                            .fetchAllUser();
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () => setState(() {
                                                                  isLoadingPage =
                                                                      false;
                                                                }));
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Save',
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 12,
                        ),
                        backgroundColor: kPrimaryBlue,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'images/logo_add.png',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'New Candidate',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ))
                ],
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
                                    context.goNamed('preparation',
                                        pathParameters: {
                                          'prepId': listUser![i].id
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
