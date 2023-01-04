import 'package:json_annotation/json_annotation.dart';

part 'api_classes.g.dart';

@JsonSerializable()
class IssueRes {
  String issueId;
  String statusCode;
  String type;
  String? summary;
  String? description;
  String? assigneeUserId;
  List<String> relatedIssues;
  List<String> relatedIssuesChildren;

  IssueRes({
    required this.issueId,
    required this.statusCode,
    required this.type,
    this.summary,
    this.description,
    this.assigneeUserId,
    required this.relatedIssues,
    required this.relatedIssuesChildren,
  });

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

@JsonSerializable()
class PutIssueReq {
  String type;
  String? summary;
  String? description;

  PutIssueReq({required this.type, this.summary, this.description});

  factory PutIssueReq.fromJson(Map<String, dynamic> json) =>
      _$PutIssueReqFromJson(json);

  Map<String, dynamic> toJson() => _$PutIssueReqToJson(this);
}

@JsonSerializable()
class PutProjectReq {
  String code;
  String? name;
  String? description;

  PutProjectReq({required this.code, this.name, this.description});

  factory PutProjectReq.fromJson(Map<String, dynamic> json) =>
      _$PutProjectReqFromJson(json);

  Map<String, dynamic> toJson() => _$PutProjectReqToJson(this);
}

@JsonSerializable()
class PostProjectReq {
  String? name;
  String? description;

  PostProjectReq({this.name, this.description});

  factory PostProjectReq.fromJson(Map<String, dynamic> json) =>
      _$PostProjectReqFromJson(json);

  Map<String, dynamic> toJson() => _$PostProjectReqToJson(this);
}

@JsonSerializable()
class StatusRes {
  String code;
  String name;
  int orderNumber;

  StatusRes(
      {required this.code, required this.name, required this.orderNumber});

  factory StatusRes.fromJson(Map<String, dynamic> json) =>
      _$StatusResFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResToJson(this);
}

@JsonSerializable()
class ChangeIssueStatusReq {
  String statusCode;

  ChangeIssueStatusReq({required this.statusCode});

  factory ChangeIssueStatusReq.fromJson(Map<String, dynamic> json) =>
      _$ChangeIssueStatusReqFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeIssueStatusReqToJson(this);
}

@JsonSerializable()
class UpdateIssueAssigneeReq {
  String assigneeUserId;

  UpdateIssueAssigneeReq({required this.assigneeUserId});

  factory UpdateIssueAssigneeReq.fromJson(Map<String, dynamic> json) =>
      _$UpdateIssueAssigneeReqFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateIssueAssigneeReqToJson(this);
}

@JsonSerializable()
class UserRes {
  String userId;
  String login;
  String email;
  String firstName;
  String? secondName;
  String surname;
  UserRes({
    required this.userId,
    required this.login,
    required this.email,
    required this.firstName,
    this.secondName,
    required this.surname,
  });

  factory UserRes.fromJson(Map<String, dynamic> json) =>
      _$UserResFromJson(json);

  Map<String, dynamic> toJson() => _$UserResToJson(this);
}
