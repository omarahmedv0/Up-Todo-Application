// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      gender: json['gender'] as String?,
      image: json['image'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'gender': instance.gender,
      'image': instance.image,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

TodoResponse _$TodoResponseFromJson(Map<String, dynamic> json) => TodoResponse(
      id: (json['id'] as num?)?.toInt(),
      completed: json['completed'] as bool?,
      todo: json['todo'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TodoResponseToJson(TodoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };

GetAllTodosByUserIdResponse _$GetAllTodosByUserIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllTodosByUserIdResponse(
      limit: (json['limit'] as num?)?.toInt(),
      skip: (json['skip'] as num?)?.toInt(),
      todosData: (json['todos'] as List<dynamic>?)
          ?.map((e) => TodoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetAllTodosByUserIdResponseToJson(
        GetAllTodosByUserIdResponse instance) =>
    <String, dynamic>{
      'todos': instance.todosData,
      'total': instance.total,
      'limit': instance.limit,
      'skip': instance.skip,
    };
