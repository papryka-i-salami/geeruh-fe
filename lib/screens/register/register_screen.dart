import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/screens/register/register_store.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/utils/state_with_lifecycle.dart';
import 'package:geeruh/widgets/universal_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  StateWithLifecycle<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends StateWithLifecycle<RegisterScreen> {
  final RegisterStore _registerStore = RegisterStore();

  @override
  void preFirstBuildInit() {
    _registerStore.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Registration to Geeruh",
                  style: GeeTextStyles.heading4),
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: Center(
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _registerStore.login = newString;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Login',
                      hintText: 'Enter Login'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _registerStore.password = newString;
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
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _registerStore.email = newString;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.envelope),
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter email",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _registerStore.firstName = newString;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First name",
                    hintText: "Enter first name",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _registerStore.secondName = newString;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Second name",
                    hintText: "Enter second name",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 70,
                child: TextField(
                  onChanged: (newString) {
                    _registerStore.surname = newString;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Surename",
                    hintText: "Enter surename",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              universalButton(350, 70, () {
                _registerStore.register(context);
              }, "Submit"),
            ],
          ),
        ],
      ),
    );
  }
}

// {
//   "login": "string",
//   "password": "string",
//   "email": "string",
//   "firstName": "string",
//   "secondName": "string",
//   "surname": "string"
// }