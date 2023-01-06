import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/main.dart';
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
              child: Image.asset('images/Logo.png'),
            ),
          ),
          const SizedBox(height: 30),
          const Text("Geeruh", style: GeeTextStyles.heading2),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _loginStore.login = newString;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Login',
                      hintText: 'Enter login'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
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
                Navigator.pushNamed(navigatorKey.currentContext!,
                    ConstantScreens.registerScreen);
              }, "Sign up"),
              const SizedBox(
                width: 15,
              ),
              geeUniversalButton(250, 70, () {
                _loginStore.loginRequest(context);
              }, "Log in"),
            ],
          ),
        ],
      ),
    );
  }
}
