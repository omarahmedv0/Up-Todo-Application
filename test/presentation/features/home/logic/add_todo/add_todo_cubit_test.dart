import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/use_case/add_todo_use_case.dart';
import 'package:up_todo_app/presentation/features/home/logic/add_todo/add_todo_cubit.dart';
import 'package:up_todo_app/presentation/features/home/logic/add_todo/add_todo_state.dart';

import 'add_todo_cubit_test.mocks.dart';

@GenerateMocks([
  AddTodoUseCase,
])
void main() {
  late AddTodoUseCase addTodoUseCase;
  late AddTodoCubit addTodoCubit;

  setUp(() {
    addTodoUseCase = MockAddTodoUseCase();
    addTodoCubit = AddTodoCubit(addTodoUseCase);
  });

  test(
    'AddTodoCubit should emit AddTodoStateLoading then AddTodoStateSuccess when calling addTodo method',
    () {
      //arrange
      AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
        todo: 'title',
        completed: false,
        userId: 1,
        id: 1,
      );

      TodoModel todoModel = TodoModel(
        id: 1,
        todo: 'title',
        completed: true,
        userId: 1,
      );

      final expectedStates = [
        const AddTodoStateLoading(),
        AddTodoStateSuccess(todoModel),
      ];

      when(addTodoUseCase.execute(addTodoRequestBody)).thenAnswer(
        (_) => Future.value(
          Right(todoModel),
        ),
      );

      //assert
      expectLater(addTodoCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      addTodoCubit.addTodo(addTodoRequestBody);
    },
  );

  test(
    '''AddTodoCubit should emit AddTodoStateLoading then AddTodoStateError
   when calling addTodo method if usecase or repository throw an ApiErrorModel''',
    () {
      //arrange
      const errorMessage = "error";
      final expectedStates = [
        const AddTodoStateLoading(),
        const AddTodoStateError(errorMessage),
      ];
      AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
        todo: 'title',
        completed: false,
        userId: 1,
        id: 1,
      );
      when(addTodoUseCase.execute(addTodoRequestBody)).thenAnswer(
        (_) => Future.value(
          Left(ApiErrorModel(message: errorMessage)),
        ),
      );

      //assert

      expectLater(addTodoCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      addTodoCubit.addTodo(addTodoRequestBody);
    },
  );
}
