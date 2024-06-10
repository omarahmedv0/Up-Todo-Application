import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/use_case/delete_todo_use_case.dart';
import 'package:up_todo_app/presentation/features/home/logic/delete_todo/delete_todo_cubit.dart';
import 'package:up_todo_app/presentation/features/home/logic/delete_todo/delete_todo_state.dart';

import 'delete_todo_cubit_test.mocks.dart';

@GenerateMocks([DeleteTodoUseCase])
void main() {
  late DeleteTodoUseCase deleteTodoUseCase;
  late DeleteTodoCubit deleteTodoCubit;

  setUp(() {
    deleteTodoUseCase = MockDeleteTodoUseCase();
    deleteTodoCubit = DeleteTodoCubit(deleteTodoUseCase);
  });

  test(
    'DeleteTodoCubit should emit DeleteTodoStateLoading then DeleteTodoStateSuccess when calling updateTodo method',
    () {
      //arrange

      TodoModel todoModel = TodoModel(
        id: 1,
        todo: 'title',
        completed: true,
        userId: 1,
      );

      final expectedStates = [
        const DeleteTodoStateLoading(),
        DeleteTodoStateSuccess(todoModel),
      ];

      when(deleteTodoUseCase.execute(1)).thenAnswer(
        (_) => Future.value(
          Right(todoModel),
        ),
      );

      //assert
      expectLater(deleteTodoCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      deleteTodoCubit.deleteTodo(1);
    },
  );

  test(
    'DeleteTodoCubit should emit DeleteTodoStateLoading then DeleteTodoStateError when calling updateTodo method',
    () {
      //arrange

      final expectedStates = [
        const DeleteTodoStateLoading(),
        const DeleteTodoStateError('error'),
      ];

      when(deleteTodoUseCase.execute(1)).thenAnswer(
        (_) => Future.value(
          Left(ApiErrorModel(message: 'error')),
        ),
      );

      //assert
      expectLater(deleteTodoCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      deleteTodoCubit.deleteTodo(1);
    },
  );
}
