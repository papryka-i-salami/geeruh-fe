import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/api/api_classes.dart';

JsonToTypeConverter _converter = JsonToTypeConverter(
  typeToMap: {HelloWorldRes: (json) => HelloWorldRes.fromJson(json)},
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

ChopperClient initChopperClient() =>
    ChopperClient(baseUrl: "http://localhost:8080");

Future<Response<T?>> apiRequest<T>(
    Future<Response<T?>> future, BuildContext context) async {
  late Response<T?> response;
  String error = "";
  try {
    response = await future.timeout(const Duration(seconds: 10));
    if (!response.isSuccessful) {
      error = jsonDecode(response.error.toString());
      // var errorDecoded = jsonDecode(response.error.toString());
      // var errorCode = errorDecoded['errorCode'];
      // var args = errorDecoded['args'] as List;
    }
  } catch (e) {
    debugPrint('$e');
  }
  if (error.isNotEmpty) {
    _showSnackBar(context, error);
    return Future.error(error);
  }
  return Future.value(response);
}

_showSnackBar(BuildContext context, String text) {
  SnackBar snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
