import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_prefs.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/helpers/local_database_helper.dart';
import '../data/networking/api_service_client.dart';
import '../data/networking/dio_factory.dart';
import '../data/networking/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/use_case/add_todo_use_case.dart';
import '../domain/use_case/clear_local_database.dart';
import '../domain/use_case/delete_todo_use_case.dart';
import '../domain/use_case/edit_todo_use_case.dart';
import '../domain/use_case/get_all_todos_by_userid_use_case.dart';
import '../domain/use_case/login_use_case.dart';

final getit = GetIt.instance;

Future<void> setupGetIt() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
  getit.registerLazySingleton(() => preferences);
   getit.registerLazySingleton<AppPreferences>(
    () => AppPreferences(preferences: preferences),
  );
  Dio dio = DioFactory.getDio();
  getit.registerLazySingleton<ApiServiceClient>(() => ApiServiceClient(dio));
  getit.registerLazySingleton<LocalDatabaseHelper>(() => LocalDatabaseHelper());

  getit.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(getit.get()));
  
  getit.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getit.get()));
  getit.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker.createInstance()));
  getit.registerLazySingleton<Repository>(() => RepositoryImpl(getit.get(), getit.get(),getit.get(),getit.get()));

  getit.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: getit.get(), ));
  getit.registerLazySingleton<ClearLocalDatabaseUseCase>(() => ClearLocalDatabaseUseCase(repository: getit.get()));

  getit.registerLazySingleton<GetAllTodosByUserIdUseCase>(() => GetAllTodosByUserIdUseCase(repository: getit.get()));
  getit.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(repository: getit.get()));
  getit.registerLazySingleton<EditTodoUseCase>(() => EditTodoUseCase(repository: getit.get(), ));
  getit.registerLazySingleton<DeleteTodoUseCase>(() => DeleteTodoUseCase(repository: getit.get(), ));


  
}
