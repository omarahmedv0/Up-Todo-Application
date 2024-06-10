// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestBody _$LoginRequestBodyFromJson(Map<String, dynamic> json) =>
    LoginRequestBody(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestBodyToJson(LoginRequestBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

AddTodoRequestBody _$AddTodoRequestBodyFromJson(Map<String, dynamic> json) =>
    AddTodoRequestBody(
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddTodoRequestBodyToJson(AddTodoRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };

UpdateTodoRequestBody _$UpdateTodoRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateTodoRequestBody(
      id: (json['id'] as num).toInt(),
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$UpdateTodoRequestBodyToJson(
        UpdateTodoRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'completed': instance.completed,
    };

GetAllTodosRequest _$GetAllTodosRequestFromJson(Map<String, dynamic> json) =>
    GetAllTodosRequest(
      limit: (json['limit'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$GetAllTodosRequestToJson(GetAllTodosRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'skip': instance.skip,
      'userId': instance.userId,
    };
