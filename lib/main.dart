import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/cookies/cookie_service.dart';
import 'package:geeruh/cookies/cookie_store.dart';
import 'package:geeruh/geeruh_navigator.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/theme.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desktop_window/desktop_window.dart';

Future<void> main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var cookieService = CookieService(preferences);
  var cookieStore = CookieStore(cookieService);
  var chopper = initChopperClient(cookieStore);
  _addProvider(chopper);
  _addProvider(cookieStore);
  _addProvider(ApiRequests.create(chopper));
  runApp(const GeeruhApp());
  DesktopWindow.setMinWindowSize(const Size(1000, 1000));
}

class GeeruhApp extends StatelessWidget {
  const GeeruhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _wrapWithProviders(
      MaterialApp(
          title: 'Geeruh',
          navigatorKey: navigatorKey,
          initialRoute: ConstantScreens.loginScreen,
          theme: geeruhThemeData(),
          onGenerateRoute: (RouteSettings settings) =>
              geeruhPageRoute(context, settings.name!, settings)),
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
