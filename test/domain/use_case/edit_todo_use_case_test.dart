import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_handler.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/edit_todo_use_case.dart';

import 'edit_todo_use_case_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
late  Repository repository;
 late EditTodoUseCase editTodoUseCase;

  setUp(() {
    repository = MockRepository();
    editTodoUseCase = EditTodoUseCase(repository: repository);
  });

  test(
    "UpdateTodoUseCase should return TodoModel when called without error",
    () async {
      //arrange
      UpdateTodoRequestBody updateTodoRequestBody = UpdateTodoRequestBody(
        completed: false,
        id: 1,
      );
      TodoModel expectValue = TodoModel(
        id: 1,
        todo: 'title',
        completed: true,
        userId: 1,
      );
      late TodoModel actualValue;
      when(repository.editTodo(updateTodoRequestBody)).thenAnswer((_) async {
        return Right(expectValue);
      });

      //act
      final result = await editTodoUseCase.execute(updateTodoRequestBody);
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
    "UpdateTodoUseCase should return apiErrorModel if there is an error",
    () async {
      //arrange
      UpdateTodoRequestBody updateTodoRequestBody = UpdateTodoRequestBody(
        completed: false,
        id: 1,
      );
      final expectedValue =DataSource.DEFAULT.getFailure();

      late ApiErrorModel actualValue;
      when(repository.editTodo(updateTodoRequestBody)).thenAnswer(
        (_) async => Left(expectedValue),
      );

      //act
      final result = await editTodoUseCase.execute(updateTodoRequestBody);
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
