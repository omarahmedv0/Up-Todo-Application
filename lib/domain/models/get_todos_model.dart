import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    todo,
    completed,
    userId
  ];
}

class GetAllTodosModel extends Equatable {
  final List<TodoModel> todosData;
  final int total;
  final int limit;
  final int skip;
  GetAllTodosModel({
    required this.todosData,  
    required this.total,
    required this.limit,
    required this.skip,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    todosData,
    total,
    limit,
    skip
  ];
}