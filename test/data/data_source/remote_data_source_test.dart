import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/data_source/remote_data_source.dart';
import 'package:up_todo_app/data/networking/api_service_client.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/data/responses/responses.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([ApiServiceClient])
void main() {
  late ApiServiceClient mockApiServiceClient;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockApiServiceClient = MockApiServiceClient();
    remoteDataSourceImpl = RemoteDataSourceImpl(mockApiServiceClient);
  });

  test("login should return LoginResponse without any exception", () async {
    //arrange
    const loginRequestBody = LoginRequestBody(
      username: "test",
      password: "test",
    );
    final loginResponse = LoginResponse(
      username: "test",
      refreshToken: "token",
      id: 1,
      token: "token",
      email: "test",
      gender: "test",
      image: "test",
      firstName: "test",
      lastName: "test",
    );
    when(mockApiServiceClient.login(loginRequestBody.toJson()))
        .thenAnswer((_) async => Future.value(loginResponse));

    //act
    final result = await remoteDataSourceImpl.login(loginRequestBody);
    //assert
    expect(result, loginResponse);
  });

  test(
      "Add todo should return TodoResponse without any exception and will add the todo to remote database",
      () async {
    //arrange
    final addTodoRequestBody = AddTodoRequestBody(
      todo: "test",
      completed: true,
      id: 1,
      userId: 1,
    );
    final todoResponse =
        TodoResponse(id: 1, todo: "test", completed: true, userId: 1);
    when(mockApiServiceClient.addTodo(addTodoRequestBody.toJson()))
        .thenAnswer((_) async => Future.value(todoResponse));

    //act
    final result = await remoteDataSourceImpl.addTodo(addTodoRequestBody);

    //assert
    expect(result, todoResponse);
  });

  test(
      "Delete todo should return TodoResponse without any exception and will delete the todo from remote database",
      () async {
    //arrange
    final todoResponse = TodoResponse(
      id: 1,
      todo: "test",
      completed: true,
      userId: 1,
    );
    when(mockApiServiceClient.deleteTodo(1))
        .thenAnswer((_) async => Future.value(todoResponse));

    //act
    final result = await remoteDataSourceImpl.deleteTodo(1);
    //assert
    expect(result, todoResponse);
  });

  test(
    "Edit todo should return TodoResponse without any exception and will edit the todo in remote database",
    () async {
      //arrange
      final updateTodoRequestBody = UpdateTodoRequestBody(
        id: 1,
        completed: true,
      );
      final todoResponse = TodoResponse(
        id: 1,
        todo: "test",
        completed: true,
        userId: 1,
      );
      when(mockApiServiceClient.editTodo(1, true))
          .thenAnswer((_) async => Future.value(todoResponse));

      //act
      final result = await remoteDataSourceImpl.editTodo(updateTodoRequestBody);
      //assert
      expect(result, todoResponse);
    },
  );

  test(
    "GetAllTodosByUserId should return GetAllTodosByUserIdResponse without any exception and will get all todos from remote database",
    () async {
      //arrange
      final getAllTodosRequest = GetAllTodosRequest(
        userId: 1,
        limit: 1,
        skip: 1,
      );
      final getAllTodosByUserIdResponse = GetAllTodosByUserIdResponse(
        todosData: [
          TodoResponse(
            id: 1,
            todo: "test",
            completed: true,
            userId: 1,
          ),
        ],
      );
      when(mockApiServiceClient.getAllTodosByUserId(1, 1, 1))
          .thenAnswer((_) async => Future.value(getAllTodosByUserIdResponse));

      //act
      final result =
          await remoteDataSourceImpl.getAllTodosByUserId(getAllTodosRequest);

      //assert
      expect(result, getAllTodosByUserIdResponse);
    },
  );
}
