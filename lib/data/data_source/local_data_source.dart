
import '../helpers/local_database_helper.dart';
import '../requests/requests.dart';
import '../responses/responses.dart';

abstract class LocalDataSource {
  Future<String> saveTheTodosFromRemoteToLocal(
    GetAllTodosByUserIdResponse getAllTodosByUserIdResponse,
  );
  Future<GetAllTodosByUserIdResponse> getAllTodosFromLocal();
  Future<String> editTodoInLocal(UpdateTodoRequestBody updateTodoRequestBody);
  Future<String> addTodoToLocal(AddTodoRequestBody addTodoRequestBody);
  Future<String> deleteTodoFromLocal(int todoID);
  Future<String> deleteDatabase();
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDatabaseHelper localDatabaseHelper;
  LocalDataSourceImpl(this.localDatabaseHelper);

  @override
  Future<String> addTodoToLocal(AddTodoRequestBody addTodoRequestBody) async {
    try {
      await localDatabaseHelper.addTodoToLocal(addTodoRequestBody);
      return "success";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> deleteDatabase() async {
    try {
      await localDatabaseHelper.deleteDatabase();

      return "success";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> deleteTodoFromLocal(int todoID) async {
    try {
      await localDatabaseHelper.deleteTodoFromLocal(todoID);
      return "success";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // 0 = Todo Not Completed, 1 = Todo Completed
  @override
  Future<String> editTodoInLocal(
      UpdateTodoRequestBody updateTodoRequestBody) async {
    try {
      await localDatabaseHelper.editTodoInLocal(updateTodoRequestBody);
      return "success";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<GetAllTodosByUserIdResponse> getAllTodosFromLocal() async {
    try {
      return await localDatabaseHelper.getAllTodosFromLocal();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> saveTheTodosFromRemoteToLocal(
      GetAllTodosByUserIdResponse getAllTodosByUserIdResponse) async {
    try {
      await localDatabaseHelper
          .saveTodosFromRemoteToLocal(getAllTodosByUserIdResponse);
      return "success";
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
