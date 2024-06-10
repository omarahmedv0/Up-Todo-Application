// ignore_for_file: avoid_renaming_method_parameters
import 'package:dartz/dartz.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/base_usecase.dart';

class GetAllTodosByUserIdUseCase
    extends BaseUseCase<GetAllTodosRequest, GetAllTodosModel> {
  Repository repository;
  GetAllTodosByUserIdUseCase({required this.repository});

  @override
  Future<Either<ApiErrorModel, GetAllTodosModel>> execute(
      GetAllTodosRequest getAllTodosRequest) async {
    return await repository.getAllTodos(getAllTodosRequest);
  }
}
