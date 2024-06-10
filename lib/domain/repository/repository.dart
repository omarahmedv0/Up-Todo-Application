import 'package:dartz/dartz.dart';
import '../../data/networking/api_error_model.dart';
import '../../data/requests/requests.dart';
import '../models/get_todos_model.dart';
import '../models/login_model.dart';

abstract class Repository {
  Future<Either<ApiErrorModel, LoginModel>> login(
      LoginRequestBody loginRequestBody);

  Future<Either<ApiErrorModel, TodoModel>> editTodo(
      UpdateTodoRequestBody updateTodoRequestBody);

  Future<Either<ApiErrorModel, TodoModel>> deleteTodo(int todoID);

  Future<Either<ApiErrorModel, TodoModel>> addTodo(
      AddTodoRequestBody addTodoRequestBody);

  Future<Either<ApiErrorModel, GetAllTodosModel>> getAllTodos(
      GetAllTodosRequest getAllTodosRequest);

  Future<String> deleteLocalDatabase();
}
