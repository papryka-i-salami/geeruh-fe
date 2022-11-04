// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_requests.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ApiRequests extends ApiRequests {
  _$ApiRequests([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiRequests;

  @override
  Future<Response<String>> getHelloWorld() {
    final String $url = '/';
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }
}
