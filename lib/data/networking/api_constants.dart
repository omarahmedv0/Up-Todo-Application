
class ApiEndPoints {
  static const String baseUrl = "https://dummyjson.com";
  static const String login = "$baseUrl/auth/login";
  static const String getAllTodosByUserID = "$baseUrl/todos?limit={limit}&skip={skip}";
//  static const String getAllTodosByUserID = "$baseUrl/todos/user/{userId}?limit={limit}&skip={skip}";
  
  static const String editTodo = "$baseUrl/todos/{todoID}";
  static const String deleteTodo = "$baseUrl/todos/{todoID}";
  static const String addTodo = "$baseUrl/todos/add";
}
class ApiErrors {
  static const String badRequestError = "bad request. try again later";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbidden request. try again later";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "url not found, try again later";
  static const String conflictError = "conflict found, try again later";
  static const String internalServerError = "some thing went wrong, try again later";
  static const String unknownError = "some thing went wrong, try again later";
  static const String timeoutError = "time out, try again late";
  static const String defaultError = "some thing went wrong, try again later";
  static const String cacheError = "cache error, try again later";
  static const String noInternetError = "Please check your internet connection";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}