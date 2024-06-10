// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:up_todo_app/app/app_prefs.dart';
import 'package:up_todo_app/app/extensions.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/use_case/clear_local_database.dart';
import 'package:up_todo_app/domain/use_case/get_all_todos_by_userid_use_case.dart';
import 'package:up_todo_app/presentation/features/home/logic/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllTodosByUserIdUseCase, this._clearLocalDatabaseUseCase,
      this.appPreferences)
      : super(const HomeStateInitial());

  final GetAllTodosByUserIdUseCase _getAllTodosByUserIdUseCase;
  final ClearLocalDatabaseUseCase _clearLocalDatabaseUseCase;
  final AppPreferences appPreferences;

  List<TodoModel> pendingTodos = [];
  List<TodoModel> doneTodos = [];
  int todosSkipped = 10;
  Future<void> loadMoreTodos() async {
    todosSkipped += 10;
    await appPreferences.setRemoteTodosStored(false);
    await getAllTodos(GetAllTodosRequest(
      limit: 10,
      skip: todosSkipped,
      userId: appPreferences.getUserId(),
    ));
  }

  Future<void> deleteTheLocalDataBase( ) async {
    emit(const DeleteTheLocalDataBaseLoading());

    await _clearLocalDatabaseUseCase.deleteLocalDatabase().then((value) async {
      emit(const DeleteTheLocalDataBaseSuccess());
    }).catchError((e) {
      emit(DeleteTheLocalDataBaseError(error: e.toString()));
    });
  }

  Future<void> getAllTodos(GetAllTodosRequest getAllTodosRequest) async {
    emit(const GetAllTodosLoading());
    log("---get todos loading");
    final result = await _getAllTodosByUserIdUseCase.execute(
      GetAllTodosRequest(
        limit: getAllTodosRequest.limit,
        skip: getAllTodosRequest.skip,
        userId: getAllTodosRequest.userId,
      ),
    );
    result.fold(
      (error) {
        log("---get todos error${error.message}");
        emit(GetAllTodosError(error: error.message.orEmpty()));
      },
      (data) {
        doneTodos.clear();
        pendingTodos.clear();
        for (var element in data.todosData) {
          if (element.completed) {
            doneTodos.add(element);
          } else if (!element.completed) {
            pendingTodos.add(element);
          }
        }
        log("---get todos success");
        emit(GetAllTodosSuccess(data: data));
      },
    );
  }
}
