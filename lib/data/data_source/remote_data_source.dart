import '../networking/api_service_client.dart';
import '../requests/requests.dart';
import '../responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequestBody loginRequestBody);
  Future<GetAllTodosByUserIdResponse> getAllTodosByUserId(
      GetAllTodosRequest getAllTodosRequest);
  Future<TodoResponse> addTodo(AddTodoRequestBody addTodoRequestBody);
  Future<TodoResponse> deleteTodo(int todoID);
  Future<TodoResponse> editTodo(UpdateTodoRequestBody updateTodoRequestBody);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  ApiServiceClient apiServiceClient;
  RemoteDataSourceImpl(this.apiServiceClient);
  @override
  Future<LoginResponse> login(LoginRequestBody loginRequestBody) async {
    return await apiServiceClient.login(loginRequestBody.toJson());
  }

  @override
  Future<TodoResponse> addTodo(AddTodoRequestBody addTodoRequestBody) async {
    return await apiServiceClient.addTodo(addTodoRequestBody.toJson());
  }

  @override
  Future<TodoResponse> deleteTodo(int todoID) async {
    return await apiServiceClient.deleteTodo(todoID);
  }

  @override
  Future<TodoResponse> editTodo(
      UpdateTodoRequestBody updateTodoRequestBody) async {
    return await apiServiceClient.editTodo(
        updateTodoRequestBody.id, updateTodoRequestBody.completed);
  }

  @override
  Future<GetAllTodosByUserIdResponse> getAllTodosByUserId(
      GetAllTodosRequest getAllTodosRequest) async {
    return await apiServiceClient.getAllTodosByUserId(
      getAllTodosRequest.userId,
      getAllTodosRequest.limit,
      getAllTodosRequest.skip,
    );
  }
}
