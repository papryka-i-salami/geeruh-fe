import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';

http.Client getHttpClient() {
  final http.Client cookieEnabledClient = http.Client();
  if (cookieEnabledClient is BrowserClient) {
    cookieEnabledClient.withCredentials = true;
  }
  return cookieEnabledClient;
}
