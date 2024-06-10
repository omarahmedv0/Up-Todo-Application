import '../../app/extensions.dart';
import '../responses/responses.dart';
import '../../domain/models/get_todos_model.dart';
import '../../domain/models/login_model.dart';

extension LoginResponseMapper on LoginResponse {
  LoginModel toDomain() {
    return LoginModel(
      token: token.orEmpty(),
      email: email.orEmpty(),
      firstName: firstName.orEmpty(),
      lastName: lastName.orEmpty(),
      image: image.orEmpty(),
      gender: gender.orEmpty(),
      id: id.orZero(),
      username: username.orEmpty(),
      refreshToken: refreshToken.orEmpty(),
    );
  }
}


extension TodoResponseMapper on TodoResponse {
  TodoModel toDomain() {
    return TodoModel(
      id: id.orZero(),
      todo: todo.orEmpty(),
      completed: completed ?? false,
      userId: userId.orZero(),
    );
  }
}


extension GetAllTodosByUserIdResponseMapper on GetAllTodosByUserIdResponse {
  GetAllTodosModel toDomain() {
    return GetAllTodosModel(
      todosData: todosData?.map((e) => e.toDomain()).toList() ?? [],
      total: total.orZero(),
      limit: limit.orZero(),
      skip: skip.orZero(),
    );
  }
}