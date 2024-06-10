import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';
import '../responses/responses.dart';

part 'api_service_client.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(
    @Body() Map<String, dynamic> data,
  );


/// I will get the todos without userID To have data to help you with the test
  @GET(ApiEndPoints.getAllTodosByUserID)
  Future<GetAllTodosByUserIdResponse> getAllTodosByUserId(
    @Path("userId") int userId,
    @Path("limit") int limit,
    @Path("skip") int skip,
  );

  @PUT(ApiEndPoints.editTodo)
  Future<TodoResponse> editTodo(
    @Path("todoID") int todoID,
    @Field("completed") bool completed,
  );

  @DELETE(ApiEndPoints.deleteTodo)
  Future<TodoResponse> deleteTodo(
    @Path("todoID") int todoID,
  );

  @POST(ApiEndPoints.addTodo)
  Future<TodoResponse> addTodo(
    @Body() Map<String, dynamic> data,
  );
}
