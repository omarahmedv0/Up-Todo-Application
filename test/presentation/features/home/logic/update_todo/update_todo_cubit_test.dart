import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/use_case/edit_todo_use_case.dart';
import 'package:up_todo_app/presentation/features/home/logic/update_todo/update_todo_cubit.dart';
import 'package:up_todo_app/presentation/features/home/logic/update_todo/update_todo_state.dart';

import 'update_todo_cubit_test.mocks.dart';

@GenerateMocks([
  EditTodoUseCase,
])
void main() {
  late EditTodoUseCase editTodoUseCase;
  late UpdateTodoCubit updateTodoCubit;

  setUp(() {
    editTodoUseCase = MockEditTodoUseCase();
    updateTodoCubit = UpdateTodoCubit(editTodoUseCase);
  });

  test(
    'UpdateTodoCubit should emit UpdateTodoStateLoading then UpdateTodoStateSuccess when calling updateTodo method',
    () {
      //arrange
      UpdateTodoRequestBody editTodoRequestBody = UpdateTodoRequestBody(
        completed: false,
        id: 1,
      );

      TodoModel todoModel = TodoModel(
        id: 1,
        todo: 'title',
        completed: true,
        userId: 1,
      );

      final expectedStates = [
        const UpdateTodoLoading(),
        UpdateTodoSuccess(todoModel),
      ];

      when(editTodoUseCase.execute(editTodoRequestBody)).thenAnswer(
        (_) => Future.value(
          Right(todoModel),
        ),
      );

      //assert
      expectLater(updateTodoCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      updateTodoCubit.editTodo(editTodoRequestBody);
    },
  );

  test(
    'UpdateTodoCubit should emit UpdateTodoStateLoading then UpdateTodoStateError when calling updateTodo method',
    () {
      //arrange
      UpdateTodoRequestBody editTodoRequestBody = UpdateTodoRequestBody(
        completed: false,
        id: 1,
      );

      final expectedStates = [
        const UpdateTodoLoading(),
        const UpdateTodoError('error'),
      ];

      when(editTodoUseCase.execute(editTodoRequestBody)).thenAnswer(
        (_) => Future.value(
           Left(ApiErrorModel(message: 'error')),
        ),
      );

      //assert
      expectLater(updateTodoCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      updateTodoCubit.editTodo(editTodoRequestBody);
    },
  );
}