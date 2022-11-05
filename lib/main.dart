import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/geeruh_navigator.dart';
import 'package:geeruh/global_constants.dart';
import 'package:provider/provider.dart' as provider;

void main() {
  var chopper = initChopperClient();
  _addProvider(chopper);
  _addProvider(ApiRequests.create(chopper));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _wrapWithProviders(
      MaterialApp(
          title: 'Geeruh',
          initialRoute: ConstantScreens.StartScreen,
          onGenerateRoute: (RouteSettings settings) =>
              geeruhPageRoute(context, settings.name!)),
    );
  }
}

List<provider.Provider<dynamic>> _providers = [];

_addProvider<T>(T service) {
  _providers += [provider.Provider<T>(create: (_) => service)];
}

Widget _wrapWithProviders(MaterialApp matieralApp) => provider.MultiProvider(
      providers: _providers,
      child: matieralApp,
    );

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
