import 'package:flutter/material.dart';
import 'package:geeruh/geeruh_navigator.dart';
import 'package:geeruh/global_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Geeruh',
      home: HomePage(title: 'Home'),
    );
  }
}

//TODO Remove this class and its state once we have more than one screen, and replace
//"home" parameter in MyApp with some othe screen
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Go to Main Menu"),
          onPressed: () {
            Navigator.push(context,
                geeruhPageRoute(context, ConstantScreens.MainMenuScreen));
          },
        ),
      ),
    );
  }
}

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
