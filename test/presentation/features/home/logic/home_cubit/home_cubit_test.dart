import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/app/app_prefs.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/use_case/clear_local_database.dart';
import 'package:up_todo_app/domain/use_case/get_all_todos_by_userid_use_case.dart';
import 'package:up_todo_app/presentation/features/home/logic/home_cubit/home_cubit.dart';
import 'package:up_todo_app/presentation/features/home/logic/home_cubit/home_state.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([
  GetAllTodosByUserIdUseCase,
  ClearLocalDatabaseUseCase,
  AppPreferences,
])
void main() {
  late HomeCubit homeCubit;
  late GetAllTodosByUserIdUseCase getAllTodosByUserIdUseCase;
  late ClearLocalDatabaseUseCase clearLocalDatabaseUseCase;
  late AppPreferences appPreferences;

  setUp(() {
    getAllTodosByUserIdUseCase = MockGetAllTodosByUserIdUseCase();
    clearLocalDatabaseUseCase = MockClearLocalDatabaseUseCase();
    appPreferences = MockAppPreferences();
    homeCubit = HomeCubit(
      getAllTodosByUserIdUseCase,
      clearLocalDatabaseUseCase,
      appPreferences,
    );
  });

  test(
      'HomeCubit should emit GetAllTodosLoading then GetAllTodosSuccess with GetAllTodosModel  when calling getAllTodos method',
      () {
    //arrange
    GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
      limit: 10,
      skip: 0,
      userId: 1,
    );
    GetAllTodosModel getAllTodosModel = GetAllTodosModel(
      todosData: [
        TodoModel(
          id: 1,
          todo: 'title',
          completed: true,
          userId: 1,
        ),
        TodoModel(
          id: 2,
          todo: 'title',
          completed: false,
          userId: 1,
        ),
      ],
      limit: 1,
      skip: 0,
      total: 2,
    );

    final expectedStates = [
      const GetAllTodosLoading(),
      GetAllTodosSuccess(data: getAllTodosModel),
    ];
    when(appPreferences.getUserId()).thenAnswer((_) => 1);
    when(getAllTodosByUserIdUseCase.execute(getAllTodosRequest)).thenAnswer(
      (_) => Future.value(
        Right(getAllTodosModel),
      ),
    );

    //assert
    expectLater(homeCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    homeCubit.getAllTodos(getAllTodosRequest);
  });

  test(
    '''HomeCubit should emit GetAllTodosLoading then GetAllTodosErrorState
   when calling getAllTodos method if usecase or repository throw an ApiErrorModel''',
    () {
      //arrange
      const errorMessage = "error";
      final expectedStates = [
        const GetAllTodosLoading(),
        GetAllTodosError(error: errorMessage),
      ];
      GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
        limit: 10,
        skip: 0,
        userId: 1,
      );

      when(getAllTodosByUserIdUseCase.execute(getAllTodosRequest)).thenAnswer(
        (_) => Future.value(
          Left(ApiErrorModel(message: errorMessage)),
        ),
      );

      //assert

      expectLater(homeCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      homeCubit.getAllTodos(getAllTodosRequest);
    },
  );

  test(
      'HomeCubit should emit DeleteTheLocalDataBaseLoading then DeleteTheLocalDataBaseSuccess when calling deleteTheLocalDataBase method',
      () {
    //arrange
    final expectedStates = [
      const DeleteTheLocalDataBaseLoading(),
      const DeleteTheLocalDataBaseSuccess(),
    ];

    when(clearLocalDatabaseUseCase.deleteLocalDatabase()).thenAnswer(
      (_) => Future.value(
        "success",
      ),
    );

    //assert
    expectLater(homeCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    homeCubit.deleteTheLocalDataBase();
  });

  test(
      'HomeCubit should emit DeleteTheLocalDataBaseLoading then DeleteTheLocalDataBaseError when calling deleteTheLocalDataBase method',
      () {
    //arrange
    final expectedStates = [
      const DeleteTheLocalDataBaseLoading(),
      DeleteTheLocalDataBaseError(error: "Exception"),
    ];

    when(clearLocalDatabaseUseCase.deleteLocalDatabase())
        .thenAnswer((_) async => throw Exception());

    //assert
    expectLater(homeCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    homeCubit.deleteTheLocalDataBase();
  });
}
