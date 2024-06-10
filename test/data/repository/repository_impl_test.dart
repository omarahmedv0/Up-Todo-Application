import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:up_todo_app/app/app_prefs.dart';
import 'package:up_todo_app/data/data_source/local_data_source.dart';
import 'package:up_todo_app/data/data_source/remote_data_source.dart';
import 'package:up_todo_app/data/mapper/mapper.dart';
import 'package:up_todo_app/data/networking/api_error_handler.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/networking/network_info.dart';
import 'package:up_todo_app/data/repository/repository_impl.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/data/responses/responses.dart';
import 'package:up_todo_app/domain/models/get_todos_model.dart';
import 'package:up_todo_app/domain/models/login_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'repository_impl_test.mocks.dart';

@GenerateMocks([
  RemoteDataSource,
  LocalDataSource,
  SharedPreferences,
  NetworkInfo,
  AppPreferences,
])
void main() {
  late RemoteDataSource remoteDataSource;
  late LocalDataSource localDataSource;
  late NetworkInfo networkInfo;
  late SharedPreferences sharedPreferences;
  late AppPreferences appPreferences;
  late Repository repository;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    sharedPreferences = MockSharedPreferences();
    appPreferences = MockAppPreferences();
    networkInfo = MockNetworkInfo();

    repository = RepositoryImpl(
      networkInfo,
      remoteDataSource,
      localDataSource,
      appPreferences,
    );
  });

  // Login tests
  test("Login should return loginModel without error if connection is true",
      () async {
    // arrange
    LoginRequestBody loginRequestBody = const LoginRequestBody(
      username: "username",
      password: "password",
    );
    LoginResponse loginResponse = LoginResponse(
      id: 1,
      token: "token",
      username: "username",
      email: "email",
      image: "image",
      firstName: "firstName",
      gender: "gender",
      lastName: "lastName",
      refreshToken: "refreshToken",
    );
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.login(loginRequestBody)).thenAnswer(
      (_) async => Future.value(
        loginResponse,
      ),
    );
    final expectedValue = loginResponse.toDomain();
    late LoginModel actualValue;

    // act
    final result = await repository.login(loginRequestBody);
    result.fold((l) => l, (loginModel) {
      actualValue = loginModel;
    });

    // assert
    expect(actualValue, expectedValue);
  });

  test("Login should return apiErrorModel if connection is false", () async {
    // arrange
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(false));
    LoginRequestBody loginRequestBody = const LoginRequestBody(
      username: "username",
      password: "password",
    );
    late ApiErrorModel actualValue;
    ApiErrorModel expectedValue =
        DataSource.NO_INTERNET_CONNECTION.getFailure();

    // act
    final result = await repository.login(loginRequestBody);

    result.fold((apiError) {
      actualValue = apiError;
    }, (loginModel) {});

    // assert
    expect(actualValue, expectedValue);
  });

  test("Login should return apiErrorModel if something goes wrong", () async {
    // arrange
    LoginRequestBody loginRequestBody = const LoginRequestBody(
      username: "username",
      password: "password",
    );
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.login(loginRequestBody)).thenThrow(
      (_) async => Future.value(
        throwsA(isA<DioException>()),
      ),
    );
    final expectedValue = ErrorHandler.handle(DioException).apiErrorModel;
    late ApiErrorModel actualValue;

    // act
    final result = await repository.login(loginRequestBody);
    result.fold((l) {
      actualValue = l;
    }, (loginModel) {});

    // assert
    expect(actualValue, expectedValue);
  });

  // Edit test
  test("Edit Todo should return todoModel without error if connection is true",
      () async {
    // arrange
    UpdateTodoRequestBody updateTodoRequestBody = UpdateTodoRequestBody(
      completed: true,
      id: 1,
    );
    TodoResponse todoResponse = TodoResponse(
      id: 1,
      todo: "todo",
      completed: true,
      userId: 1,
    );
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(localDataSource.editTodoInLocal(updateTodoRequestBody)).thenAnswer(
      (_) async => Future.value("success"),
    );
    when(remoteDataSource.editTodo(updateTodoRequestBody)).thenAnswer(
      (_) async => Future.value(
        todoResponse,
      ),
    );
    TodoModel expectedRemoteValue = todoResponse.toDomain();
    String expectedLocalValue = "success";
    late TodoModel actualRemoteValue;
    late String actualLocalValue;

    // act
    final result = await repository.editTodo(updateTodoRequestBody);
    actualLocalValue =
        await localDataSource.editTodoInLocal(updateTodoRequestBody);
    result.fold((l) {}, (todo) {
      actualRemoteValue = todo;
    });

    // assert
    expect(actualLocalValue, expectedLocalValue);
    expect(actualRemoteValue, expectedRemoteValue);
  });

  test("Edit todo should return apiErrorModel if connection is false",
      () async {
    // arrange
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(false));
    UpdateTodoRequestBody updateTodoRequestBody = UpdateTodoRequestBody(
      completed: true,
      id: 1,
    );
    late ApiErrorModel actualValue;
    ApiErrorModel expectedValue =
        DataSource.NO_INTERNET_CONNECTION.getFailure();

    // act
    final result = await repository.editTodo(updateTodoRequestBody);
    result.fold((apiError) {
      actualValue = apiError;
    }, (todo) {});

    // assert
    expect(actualValue, expectedValue);
  });

  test("Edit todo should return apiErrorModel if something goes wrong",
      () async {
    // arrange
    UpdateTodoRequestBody updateTodoRequestBody = UpdateTodoRequestBody(
      completed: true,
      id: 1,
    );
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.editTodo(updateTodoRequestBody)).thenThrow(
      (_) async => Future.value(
        throwsA(isA<DioException>()),
      ),
    );
    final expectedValue = ErrorHandler.handle(DioException).apiErrorModel;
    late ApiErrorModel actualValue;

    // act
    final result = await repository.editTodo(updateTodoRequestBody);
    result.fold((l) {
      actualValue = l;
    }, (todo) {});

    // assert
    expect(actualValue, expectedValue);
  });

  // Add test
  test("Add todo should return todoModel without error if connection is true",
      () async {
    // arrange
    AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
      todo: "todo",
      completed: true,
      userId: 1,
      id: 1,
    );
    TodoResponse todoModel = TodoResponse(
      id: 1,
      todo: "todo",
      completed: true,
      userId: 1,
    );
    TodoModel expectedRemoteValue = todoModel.toDomain();
    String expectedLocalValue = "success";
    late TodoModel actualRemoteValue;
    late String actualLocalValue;
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(localDataSource.addTodoToLocal(addTodoRequestBody)).thenAnswer(
      (_) async => Future.value("success"),
    );
    when(remoteDataSource.addTodo(addTodoRequestBody)).thenAnswer(
      (_) async => Future.value(
        todoModel,
      ),
    );

    // act
    final result = await repository.addTodo(addTodoRequestBody);
    actualLocalValue = await localDataSource.addTodoToLocal(addTodoRequestBody);
    result.fold((l) {}, (todo) {
      actualRemoteValue = todo;
    });

    // assert
    expect(actualLocalValue, expectedLocalValue);
    expect(actualRemoteValue, expectedRemoteValue);
  });

  test("Add todo should return apiErrorModel if connection is false", () async {
    // arrange
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(false));
    AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
      todo: "todo",
      completed: true,
      userId: 1,
      id: 1,
    );
    late ApiErrorModel actualValue;
    ApiErrorModel expectedValue =
        DataSource.NO_INTERNET_CONNECTION.getFailure();

    // act
    final result = await repository.addTodo(addTodoRequestBody);
    result.fold((apiError) {
      actualValue = apiError;
    }, (todo) {});

    // assert
    expect(actualValue, expectedValue);
  });

  test("Add todo should return apiErrorModel if something goes wrong",
      () async {
    // arrange
    AddTodoRequestBody addTodoRequestBody = AddTodoRequestBody(
      todo: "todo",
      completed: true,
      userId: 1,
      id: 1,
    );
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.addTodo(addTodoRequestBody)).thenThrow(
      (_) async => Future.value(
        throwsA(isA<DioException>()),
      ),
    );
    late ApiErrorModel actualValue;
    final expectedValue = ErrorHandler.handle(DioException).apiErrorModel;

    // act
    final result = await repository.addTodo(addTodoRequestBody);
    result.fold((l) {
      actualValue = l;
    }, (todo) {});

    // assert
    expect(actualValue, expectedValue);
  });

  // Delete tests
  test(
      "Delete todo should return todoModel without error if connection is true",
      () async {
    // arrange
    TodoResponse todoResponse = TodoResponse(
      id: 1,
      todo: "todo",
      completed: true,
      userId: 1,
    );

    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(localDataSource.deleteTodoFromLocal(1)).thenAnswer(
      (_) async => Future.value("success"),
    );
    when(remoteDataSource.deleteTodo(1)).thenAnswer(
      (_) async => Future.value(
        todoResponse,
      ),
    );

    TodoModel expectedRemoteValue = todoResponse.toDomain();
    String expectedLocalValue = "success";
    late TodoModel actualRemoteValue;
    late String actualLocalValue;

    // act
    final result = await repository.deleteTodo(1);
    actualLocalValue = await localDataSource.deleteTodoFromLocal(1);
    result.fold((l) {}, (todo) {
      actualRemoteValue = todo;
    });

    // assert
    expect(actualLocalValue, expectedLocalValue);
    expect(actualRemoteValue, expectedRemoteValue);
  });
  test("Delete todo should return apiErrorModel if connection is false",
      () async {
    // arrange
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(false));

    late ApiErrorModel actualValue;
    ApiErrorModel expectedValue =
        DataSource.NO_INTERNET_CONNECTION.getFailure();

    // act
    final result = await repository.deleteTodo(1);
    result.fold((apiError) {
      actualValue = apiError;
    }, (todo) {});

    // assert
    expect(actualValue, expectedValue);
  });
  test("Delete todo should return apiErrorModel if something goes wrong",
      () async {
    // arrange
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.deleteTodo(1)).thenThrow(
      (_) async => Future.value(
        throwsA(isA<DioException>()),
      ),
    );

    late ApiErrorModel actualValue;
    final expectedValue = ErrorHandler.handle(DioException).apiErrorModel;

    // act
    final result = await repository.deleteTodo(1);
    result.fold((l) {
      actualValue = l;
    }, (todo) {});

    // assert
    expect(actualValue, expectedValue);
  });

  test("Delete The local database should return success message without error",
      () async {
    // arrange
    when(localDataSource.deleteDatabase()).thenAnswer(
      (_) async => Future.value("success"),
    );
    String expectedValue = "success";

    // act
    final result = await repository.deleteLocalDatabase();
    String actualValue = result;

    // assert
    expect(actualValue, expectedValue);
  });

  // Get tests
  test(
      '''Get All Todos should return GetAllTodosModel when internet connection is true and isRemoteTodosStored is false. 
      this function will get remote data and store it in local database and return GetAllTodosModel without error''',
      () async {
    // arrange
    GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
      userId: 1,
      limit: 1,
      skip: 1,
    );
    GetAllTodosByUserIdResponse getAllTodosByUserIdResponse =
        GetAllTodosByUserIdResponse(
      todosData: [
        TodoResponse(
          id: 1,
          todo: "todo",
          completed: true,
          userId: 1,
        ),
      ],
    );

    when(appPreferences.isRemoteTodosStored()).thenReturn(false);
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.getAllTodosByUserId(getAllTodosRequest)).thenAnswer(
      (_) async => Future.value(
        getAllTodosByUserIdResponse,
      ),
    );
    when(localDataSource.getAllTodosFromLocal()).thenAnswer(
      (_) async => Future.value(
        getAllTodosByUserIdResponse,
      ),
    );
    when(localDataSource
            .saveTheTodosFromRemoteToLocal(getAllTodosByUserIdResponse))
        .thenAnswer(
      (_) async => Future.value("success"),
    );

    late GetAllTodosModel actualValue;

    // act
    final result = await repository.getAllTodos(getAllTodosRequest);
    result.fold((apiError) {}, (todos) {
      actualValue = todos;
    });

    // assert
    expect(actualValue, getAllTodosByUserIdResponse.toDomain());
  });

  test(
      'Get all todos should return apiErrorModel (NO INTERNET CONNECTION ERROR) when internet connection is false.',
      () async {
    // arrange
    late ApiErrorModel actualValue;
    ApiErrorModel expectedValue =
        DataSource.NO_INTERNET_CONNECTION.getFailure();
    GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
      userId: 1,
      limit: 1,
      skip: 1,
    );
    when(appPreferences.isRemoteTodosStored()).thenReturn(false);
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(false));

    // act
    final result = await repository.getAllTodos(getAllTodosRequest);
    result.fold((apiError) {
      actualValue = apiError;
    }, (todos) {});

    // assert
    expect(actualValue, expectedValue);
  });

  test('Get all todos should return apiErrorModel if something goes wrong.',
      () async {
    // arrange
    final expectedValue = ErrorHandler.handle(DioException).apiErrorModel;
    late ApiErrorModel actualValue;

    GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
      userId: 1,
      limit: 1,
      skip: 1,
    );
    GetAllTodosByUserIdResponse getAllTodosByUserIdResponse =
        GetAllTodosByUserIdResponse(
      todosData: [
        TodoResponse(
          id: 1,
          todo: "todo",
          completed: true,
          userId: 1,
        ),
      ],
    );

    when(appPreferences.isRemoteTodosStored()).thenReturn(false);
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(remoteDataSource.getAllTodosByUserId(getAllTodosRequest)).thenThrow(
      (_) async => Future.value(
        throwsA(isA<DioException>()),
      ),
    );
    when(localDataSource.getAllTodosFromLocal()).thenAnswer(
      (_) async => Future.value(
        getAllTodosByUserIdResponse,
      ),
    );
    when(localDataSource
            .saveTheTodosFromRemoteToLocal(getAllTodosByUserIdResponse))
        .thenAnswer(
      (_) async => Future.value("success"),
    );

    // act
    final result = await repository.getAllTodos(getAllTodosRequest);
    result.fold((apiError) {
      actualValue = apiError;
    }, (todos) {});

    // assert
    expect(actualValue, expectedValue);
  });
  test(
      '''Get All Todos should return GetAllTodosModel when internet connection is true and isRemoteTodosStored is true. 
      this function will get the data from local database only''',
      () async {
    // arrange
    GetAllTodosRequest getAllTodosRequest = GetAllTodosRequest(
      userId: 1,
      limit: 1,
      skip: 1,
    );
    GetAllTodosByUserIdResponse getAllTodosByUserIdResponse =
        GetAllTodosByUserIdResponse(
      todosData: [
        TodoResponse(
          id: 1,
          todo: "todo",
          completed: true,
          userId: 1,
        ),
      ],
    );

    when(appPreferences.isRemoteTodosStored()).thenReturn(true);
    when(networkInfo.isConnected).thenAnswer((_) async => Future.value(true));
    when(localDataSource.getAllTodosFromLocal()).thenAnswer(
      (_) async => Future.value(
        getAllTodosByUserIdResponse,
      ),
    );

    late GetAllTodosModel actualValue;

    // act
    final result = await repository.getAllTodos(getAllTodosRequest);
    result.fold((apiError) {}, (todos) {
      actualValue = todos;
    });

    // assert
    expect(actualValue, getAllTodosByUserIdResponse.toDomain());
  });
}
