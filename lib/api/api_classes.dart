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

@JsonSerializable()
class IssueRes {
  String issueId;
  String type;
  String? summary;
  String? description;

  IssueRes(
      {required this.issueId,
      required this.type,
      this.summary,
      this.description});

  factory IssueRes.fromJson(Map<String, dynamic> json) =>
      _$IssueResFromJson(json);

  Map<String, dynamic> toJson() => _$IssueResToJson(this);
}

@JsonSerializable()
class ProjectRes {
  String code;
  String name;
  String? description;

  ProjectRes({required this.code, required this.name, this.description});

  factory ProjectRes.fromJson(Map<String, dynamic> json) =>
      _$ProjectResFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectResToJson(this);
}

@JsonSerializable()
class LoginReq {
  String username;
  String password;
  LoginReq({
    required this.username,
    required this.password,
  });

  factory LoginReq.fromJson(Map<String, dynamic> json) =>
      _$LoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$LoginReqToJson(this);
}
