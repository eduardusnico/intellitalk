import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/src/data/dataproviders/backend.dart';
import 'package:intellitalk/src/data/models/user_m.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool isLoadingPage = true;
  final backend = Backend();
  List<User>? listUser;
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
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        color: Colors.white,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.person),
              Text('List user'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.question_answer),
              Text('List pertanyaan'),
            ],
          )
        ]),
      ),
      appBar: AppBar(
        title: const Text('Admin page'),
      ),
      body: isLoadingPage == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Table(
                  columnWidths: const {
                    0: FixedColumnWidth(150),
                    1: FixedColumnWidth(150),
                    2: FixedColumnWidth(150),
                  },
                  border: TableBorder.all(),
                  children: [
                    const TableRow(decoration: BoxDecoration(), children: [
                      Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Division',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Position',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Skill',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Link',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ]),
                    for (int i = 0; i < listUser!.length; i++)
                      TableRow(children: [
                        Text(listUser![i].name),
                        Text(listUser![i].division),
                        Text(listUser![i].position),
                        Text(listUser![i].skill),
                        TextButton(
                          onPressed: () {
                            context.goNamed('conversation',
                                pathParameters: {'convoId': listUser![i].id});
                          },
                          child: Text(
                            listUser![i].link,
                          ),
                        ),
                      ])
                  ]),
            ]),
    );
  }
}
