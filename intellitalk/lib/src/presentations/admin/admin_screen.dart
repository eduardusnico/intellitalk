import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
      ),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              context
                  .goNamed('conversation', pathParameters: {'convoId': '123'});
            },
            child: const Text('start convo'))
      ]),
    );
  }
}
