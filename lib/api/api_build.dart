import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/cookies/cookie_store.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/main.dart';
import 'package:geeruh/theme.dart';

JsonToTypeConverter _converter = JsonToTypeConverter(
  typeToMap: {
    HelloWorldRes: (json) => HelloWorldRes.fromJson(json),
    IssueRes: (json) => IssueRes.fromJson(json)
  },
);

class JsonToTypeConverter extends JsonConverter {
  const JsonToTypeConverter({required this.typeToMap});
  final Map<Type, Function> typeToMap;

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
          utf8.decode(response.bodyBytes), typeToMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    if (jsonData.isNotEmpty) {
      var jsonMap = json.decode(jsonData);
      if (jsonParser != null) {
        if (jsonMap is List) {
          return jsonMap
              .map((item) =>
                  jsonParser(item as Map<String, dynamic>) as InnerType)
              .toList() as T;
        }

        return jsonParser(jsonMap);
      }
    }
    return null as T;
  }
}

class CookieInterceptor extends RequestInterceptor {
  final CookieStore _cookieStore;

  CookieInterceptor(this._cookieStore);

  @override
  FutureOr<Request> onRequest(Request request) async {
    String cookieValue = _cookieStore.cookieValue;

    return request.copyWith(
      headers: {
        ...{"Cookie": cookieValue},
        ...request.headers,
      },
    );
  }
}

ChopperClient initChopperClient(CookieStore cookieStore) => ChopperClient(
    baseUrl: ConstantDev.hostAddress,
    converter: _converter,
    interceptors: [CookieInterceptor(cookieStore)]);

Future<Response<T?>> apiRequest<T>(
    Future<Response<T?>> future, BuildContext context) async {
  late Response<T?> response;
  String errorMessage = "";
  try {
    response = await future.timeout(const Duration(seconds: 10));
    if (!response.isSuccessful) {
      Map jsonMap = Map.from(json.decode(response.error.toString()).first);
      errorMessage = jsonMap["message"];
    }
  } catch (e) {
    debugPrint('$e');
    errorMessage = "Wystapil blad";
  }
  if (errorMessage.isNotEmpty) {
    _showSnackBar(errorMessage);
    return Future.error(errorMessage);
  }
  return Future.value(response);
}

_showSnackBar(String text) {
  SnackBar snackBar = SnackBar(
    content: Text(
      text,
      style: GeeTextStyles.paragraph2,
    ),
    backgroundColor: GeeColors.red,
  );
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}
