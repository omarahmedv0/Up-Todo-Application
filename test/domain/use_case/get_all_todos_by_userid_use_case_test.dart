import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_handler.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/get_all_todos_by_userid_use_case.dart';

import 'get_all_todos_by_userid_use_case_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
 late Repository repository;
  late GetAllTodosByUserIdUseCase getAllTodosByUserIdUseCase;

  setUp(() {
    repository = MockRepository();
    getAllTodosByUserIdUseCase =
        GetAllTodosByUserIdUseCase(repository: repository);
  });
  test(
    "GetAllTodosByUserIdUseCase should return GetAllTodosModel when called without error",
    () async {
      //arrange
      GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
        userId: 1,
        limit: 1,
        skip: 1,
      );
      GetAllTodosModel expectValue = GetAllTodosModel(
        todosData: [
          TodoModel(
            id: 1,
            todo: 'title',
            completed: true,
            userId: 1,
          )
        ],
      limit: 1,
      skip:   1,
      total: 1,
      );
      late GetAllTodosModel actualValue;
      when(repository.getAllTodos(getAllTodosRequest)).thenAnswer((_) async {
        return Right(expectValue);
      });

      //act
      final result = await getAllTodosByUserIdUseCase.execute(getAllTodosRequest);
      result.fold(
        (apiError) {},
        (todos) {
          actualValue = todos;
        },
      );
      //assert
      expect(actualValue, expectValue);
    },
  );

  test(
    "GetAllTodosByUserIdUseCase should return apiErrorModel if there is an error",
    () async {
      //arrange
       GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
        userId: 1,
        limit: 1,
        skip: 1,
      );
      final expectedValue = DataSource.DEFAULT.getFailure();

      late ApiErrorModel actualValue;
      when(repository.getAllTodos(getAllTodosRequest)).thenAnswer(
        (_) async => Left(expectedValue),
      );

      //act
      final result = await getAllTodosByUserIdUseCase.execute(getAllTodosRequest);
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
