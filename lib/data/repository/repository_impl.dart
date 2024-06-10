import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../app/app_prefs.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../mapper/mapper.dart';
import '../networking/api_error_handler.dart';
import '../networking/api_error_model.dart';
import '../networking/network_info.dart';
import '../requests/requests.dart';
import '../responses/responses.dart';
import '../../domain/models/get_todos_model.dart';
import '../../domain/models/login_model.dart';
import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  NetworkInfo networkInfo;
  RemoteDataSource remoteDataSource;
  LocalDataSource localDataSource;

  final AppPreferences appPreferences;
  RepositoryImpl(this.networkInfo, this.remoteDataSource, this.localDataSource,
      this.appPreferences);
  @override
  Future<Either<ApiErrorModel, LoginModel>> login(
      LoginRequestBody loginRequestBody) async {
    if (await networkInfo.isConnected) {
      try {
        final LoginResponse response =
            await remoteDataSource.login(loginRequestBody);

        return right(response.toDomain());
      } catch (error) {
        return left(ErrorHandler.handle(error).apiErrorModel);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, TodoModel>> addTodo(
      AddTodoRequestBody addTodoRequestBody) async {
    if (await networkInfo.isConnected) {
      try {
        final TodoResponse response =
            await remoteDataSource.addTodo(addTodoRequestBody);

        await localDataSource.addTodoToLocal(addTodoRequestBody);

        return right(response.toDomain());
      } catch (error) {
        return left(ErrorHandler.handle(error).apiErrorModel);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, TodoModel>> deleteTodo(int todoID) async {
    if (await networkInfo.isConnected) {
      try {
        /// Note: Todo with id '255' not found
        /// this because "Adding a new todo will not add it into the server.". its just simulate for testing.

        final TodoResponse response = await remoteDataSource.deleteTodo(todoID);
        await localDataSource.deleteTodoFromLocal(todoID);
        return right(response.toDomain());
      } catch (error) {
        return left(ErrorHandler.handle(error).apiErrorModel);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, TodoModel>> editTodo(
      UpdateTodoRequestBody updateTodoRequestBody) async {
    if (await networkInfo.isConnected) {
      try {
        /// Note: Todo with id '255' not found
        /// this because "Adding a new todo will not add it into the server.". its just simulate for testing.

        final TodoResponse response =
            await remoteDataSource.editTodo(updateTodoRequestBody);

        await localDataSource.editTodoInLocal(updateTodoRequestBody);
        return right(response.toDomain());
      } catch (error) {
        return left(ErrorHandler.handle(error).apiErrorModel);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<ApiErrorModel, GetAllTodosModel>> getAllTodos(
      GetAllTodosRequest getAllTodosRequest) async {
    try {
      if (appPreferences.isRemoteTodosStored() == false) {
        if (await networkInfo.isConnected) {
          final GetAllTodosByUserIdResponse todosFromRemote =
              await remoteDataSource.getAllTodosByUserId(getAllTodosRequest);
          await localDataSource.saveTheTodosFromRemoteToLocal(todosFromRemote);
          appPreferences.setRemoteTodosStored(true);
        } else {
          return left(
            DataSource.NO_INTERNET_CONNECTION.getFailure(),
          );
        }
      }
      GetAllTodosByUserIdResponse response =
          await localDataSource.getAllTodosFromLocal();

      return right(response.toDomain());
    } catch (error) {
      log(error.toString());
      return left(ErrorHandler.handle(error).apiErrorModel);
    }
  }

  @override
  Future<String> deleteLocalDatabase() async {
    try {
      await localDataSource.deleteDatabase();
      return "success";
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
