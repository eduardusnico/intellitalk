import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intellitalk/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    passwordFocus = FocusNode();
    asyncFunction();
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  void asyncFunction() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogin') == true) {
      context.goNamed('admin');
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                'Welcome to Intellitalk',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kWhite, fontSize: 29),
              ),
              SizedBox(height: 30),
              Text(
                'Login first to add new candidate,\nor see candidate results',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: kWhite, fontSize: 17),
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
          child: Form(
            key: _formKey,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                const Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      passwordFocus.requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field tidak boleh kosong';
                      } else if (value.toLowerCase() != 'admin') {
                        return 'Username salah';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
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
                  child: TextFormField(
                    focusNode: passwordFocus,
                    onFieldSubmitted: (value) async {
                      if (_formKey.currentState!.validate() == true) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs
                            .setBool('isLogin', true)
                            .then((value) => context.goNamed('admin'));
                      }
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field tidak boleh kosong';
                      } else if (value != 'admin') {
                        return 'Password salah';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        backgroundColor: kPrimaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 24)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() == true) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs
                            .setBool('isLogin', true)
                            .then((value) => context.goNamed('admin'));
                      }
                    },
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
