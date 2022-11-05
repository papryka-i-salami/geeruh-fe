import 'package:json_annotation/json_annotation.dart';

part 'api_classes.g.dart';

@JsonSerializable()
class HelloWorldRes {
  String hello;

  HelloWorldRes(this.hello);

  factory HelloWorldRes.fromJson(Map<String, dynamic> json) =>
      _$HelloWorldResFromJson(json);

  Map<String, dynamic> toJson() => _$HelloWorldResToJson(this);
}
