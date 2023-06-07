import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Container(
          color: kPrimaryBlue,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Hello Friend!',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kWhite, fontSize: 44),
              ),
              SizedBox(height: 30),
              Text(
                'This is bot interview arkademi,\nadmin must login first to input data\ncandidate.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kWhite, fontSize: 20),
              )
            ],
          ),
        ),
        Container(
          color: kWhite,
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03,
              top: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.width * 0.07),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Image.asset(
                    '/images/logo_arkademi_blue.png',
                    height: 40,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              const Text(
                'Welcome to\nArkademi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(height: 28),
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 24)),
                  onPressed: () {
                    context.goNamed('admin');
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ]),
    );
  }
}
