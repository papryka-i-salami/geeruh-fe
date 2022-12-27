import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/screens/login/login_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/gee_universal_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  StateWithLifecycle<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends StateWithLifecycle<LoginScreen> {
  final LoginStore _loginStore = LoginStore();

  @override
  void preFirstBuildInit() {
    _loginStore.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Container(
            height: 300.0,
            width: 300.0,
            padding: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Image.asset('images/logo.png'),
            ),
          ),
          const SizedBox(height: 30),
          const Text("Geeruh", style: GeeTextStyles.heading2),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width / 2.5,
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _loginStore.username = newString;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.envelope),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter username'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width / 2.5,
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _loginStore.password = newString;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.padlock),
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter password",
                  ),
                  obscureText: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              geeUniversalButton(250, 70, () {
                _loginStore.login(context);
              }, "Log in"),
            ],
          ),
        ],
      ),
    );
  }
}
