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

@JsonSerializable()
class RegisterReq {
  String login;
  String password;
  String email;
  String firstName;
  String secondName;
  String surname;
  RegisterReq({
    required this.login,
    required this.password,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.surname,
  });

  factory RegisterReq.fromJson(Map<String, dynamic> json) =>
      _$RegisterReqFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterReqToJson(this);
}

@JsonSerializable()
class RegisterRes {
  String userId;
  String login;
  String email;
  String firstName;
  String secondName;
  String surname;
  RegisterRes({
    required this.userId,
    required this.login,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.surname,
  });

  factory RegisterRes.fromJson(Map<String, dynamic> json) =>
      _$RegisterResFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResToJson(this);
}
