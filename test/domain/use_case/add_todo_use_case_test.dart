import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_handler.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/add_todo_use_case.dart';

import 'add_todo_use_case_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late Repository repository;
  late AddTodoUseCase addTodoUseCase;

  setUp(() {
    repository = MockRepository();
    addTodoUseCase = AddTodoUseCase(repository: repository);
  });

  test(
    "AddTodoUseCase should return TodoModel when called without error",
    () async {
      //arrange
      AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
        todo: 'title',
        completed: false,
        userId: 1,
        id: 1,
      );
      TodoModel expectValue = TodoModel(
        id: 1,
        todo: 'title',
        completed: true,
        userId: 1,
      );
      late TodoModel actualValue;
      when(repository.addTodo(addTodoRequestBody)).thenAnswer((_) async {
        return Right(expectValue);
      });

      //act
      final result = await addTodoUseCase.execute(addTodoRequestBody);
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
    "AddTodoUseCase should return apiErrorModel if there is an error",
    () async {
      //arrange
      AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
        todo: 'title',
        completed: false,
        userId: 1,
        id: 1,
      );
      final expectedValue =DataSource.DEFAULT.getFailure();

      late ApiErrorModel actualValue;
      when(repository.addTodo(addTodoRequestBody)).thenAnswer(
        (_) async => Left(expectedValue),
      );

      //act
      final result = await addTodoUseCase.execute(addTodoRequestBody);
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
