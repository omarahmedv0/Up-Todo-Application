// ignore_for_file: avoid_renaming_method_parameters
import 'package:dartz/dartz.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/base_usecase.dart';

class DeleteTodoUseCase extends BaseUseCase<int , TodoModel> {
  Repository repository;
  DeleteTodoUseCase({required this.repository});

  @override
  Future<Either<ApiErrorModel, TodoModel>> execute(int todoID) async {
    return await repository.deleteTodo(todoID);
  }
}
