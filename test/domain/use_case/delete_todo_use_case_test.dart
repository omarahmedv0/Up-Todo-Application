import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_handler.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/delete_todo_use_case.dart';

import 'clear_local_database_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late Repository repository;
  late DeleteTodoUseCase deleteTodoUseCase;

  setUp(() {
    repository = MockRepository();
    deleteTodoUseCase = DeleteTodoUseCase(repository: repository);
  });

  test(
    "DeleteTodoUseCase should return TodoModel when called without error",
    () async {
      //arrange
    
      TodoModel expectValue = TodoModel(
        id: 1,
        todo: 'title',
        completed: true,
        userId: 1,
      );
      late TodoModel actualValue;
      when(repository.deleteTodo(1)).thenAnswer((_) async {
        return Right(expectValue);
      });

      //act
      final result = await deleteTodoUseCase.execute(1);
      result.fold(
        (apiError) {},
        (todo) {
          actualValue = todo;
        },
      );
      //assert
      expect(actualValue, expectValue);
    },
  );

  test(
    "DeleteTodoUseCase should return apiErrorModel if there is an error",
    () async {
      //arrange
     
      final expectedValue =DataSource.DEFAULT.getFailure();

      late ApiErrorModel actualValue;
      when(repository.deleteTodo(1)).thenAnswer(
        (_) async => Left(expectedValue),
      );

      //act
      final result = await deleteTodoUseCase.execute(1);
      result.fold(
        (apiError) {
          actualValue = apiError;
        },
        (todo) {},
      );
      //assert
      expect(actualValue, expectedValue);
    },
  );
}
