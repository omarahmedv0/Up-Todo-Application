import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'requests.g.dart';

@JsonSerializable()
class LoginRequestBody extends Equatable {
  final String username;
  final String password;
  const LoginRequestBody({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}

@JsonSerializable()
class AddTodoRequestBody {
  int? id;
  final String todo;
  final bool completed;
  final int userId;
  AddTodoRequestBody(
      {required this.todo,
      required this.completed,
      required this.userId,
      this.id});

  Map<String, dynamic> toJson() => _$AddTodoRequestBodyToJson(this);
}

@JsonSerializable()
class UpdateTodoRequestBody {
  final int id;
  final bool completed;
  UpdateTodoRequestBody({
    required this.id,
    required this.completed,
  });

  Map<String, dynamic> toJson() => _$UpdateTodoRequestBodyToJson(this);
}

@JsonSerializable()
class GetAllTodosRequest extends Equatable {
  final int limit;
  final int skip;
  final int userId;

  GetAllTodosRequest({
    required this.limit,
    required this.skip,
    required this.userId,
  });

  Map<String, dynamic> toJson() => _$GetAllTodosRequestToJson(this);
  
  @override
  // TODO: implement props
  List<Object?> get props => [limit, skip, userId];
}
