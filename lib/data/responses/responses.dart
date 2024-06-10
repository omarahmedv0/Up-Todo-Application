import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class LoginResponse {
  int? id;
  String? username;
  String? email;
  String? token;
  String? refreshToken;
  String? gender;
  String? image;
  String? firstName;
  String? lastName;

  LoginResponse({
    this.id,
    this.username,
    this.email,
    this.token,
    this.refreshToken,
    this.gender,
    this.image,
    this.firstName,
    this.lastName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
@JsonSerializable()
class TodoResponse {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoResponse({this.id, this.completed, this.todo, this.userId});
  factory TodoResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoResponseToJson(this);
}

@JsonSerializable()
class GetAllTodosByUserIdResponse {
  @JsonKey(name: "todos")
  List<TodoResponse>? todosData;
  int? total;
  int? limit;
  int? skip;
  GetAllTodosByUserIdResponse({
    this.limit,
    this.skip,
    this.todosData,
    this.total,
  });

  factory GetAllTodosByUserIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllTodosByUserIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTodosByUserIdResponseToJson(this);
}


