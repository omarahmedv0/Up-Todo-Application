import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/data_source/local_data_source.dart';
import 'package:up_todo_app/data/helpers/local_database_helper.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/data/responses/responses.dart';

import 'local_data_source_test.mocks.dart';

@GenerateMocks([LocalDatabaseHelper])
void main() {
  late LocalDataSource localDataSource;
  late LocalDatabaseHelper localDatabaseHelper;
  setUp(() async {
    localDatabaseHelper = MockLocalDatabaseHelper();
    localDataSource = LocalDataSourceImpl(localDatabaseHelper);
  });

  test(
      "Add Todo To Local should return success message and add the todo to local database",
      () async {
    // Arrange
    final addTodoRequestBody = AddTodoRequestBody(
      id: 1,
      todo: "test",
      completed: true,
      userId: 1,
    );

    // Act
    final result = await localDataSource.addTodoToLocal(addTodoRequestBody);

    // Assert
    expect(result, "success");
  });

  test(
      "Delete Todo From Local should return success message and delete the todo from local database",
      () async {
    // Act
    final result = await localDataSource.deleteTodoFromLocal(1);

    // Assert
    expect(result, "success");
  });

  test(
      "Edit Todo In Local should return success message and edit the todo in local database",
      () async {
    // Arrange
    UpdateTodoRequestBody updateTodoRequestBody = UpdateTodoRequestBody(
      id: 1,
      completed: true,
    );

    // Act
    final result = await localDataSource.editTodoInLocal(updateTodoRequestBody);

    // Assert
    expect(result, "success");
  });

  test(
      "Delete Database should return success message and delete the table",
      () async {
    // Act
    final result = await localDataSource.deleteDatabase();

    // Assert
    expect(result, "success");
  });

  test(
      "Get All Todos From Local should return success message and get all todos from local database",
      () async {
    // Arrange
    GetAllTodosByUserIdResponse getAllTodosByUserIdResponse =
        GetAllTodosByUserIdResponse(
      todosData: [
        TodoResponse(
          id: 1,
          todo: "test",
          completed: true,
          userId: 1,
        ),
      ],
      limit: 0,
      skip: 0,
      total: 1,
    );

    when(localDatabaseHelper.getAllTodosFromLocal())
        .thenAnswer((_) async => getAllTodosByUserIdResponse);

    // Act
    final result = await localDataSource.getAllTodosFromLocal();

    // Assert
    expect(result, getAllTodosByUserIdResponse);
  });

  test(
      "Save The Todos From Remote To Local should return success message and save the todos from remote to local database",
      () async {
        // Arrange
    GetAllTodosByUserIdResponse getAllTodosByUserIdResponse =
        GetAllTodosByUserIdResponse(
      todosData: [
        TodoResponse(
          id: 1,
          todo: "test",
          completed: true,
          userId: 1,
        ),
      ],
      limit: 0,
      skip: 0,
      total: 1,
    );

    // Act
    final result = await localDataSource.saveTheTodosFromRemoteToLocal(getAllTodosByUserIdResponse);

    // Assert
    expect(result, "success");
  });
}
