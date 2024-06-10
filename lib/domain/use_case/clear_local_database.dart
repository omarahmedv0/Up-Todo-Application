// ignore_for_file: avoid_renaming_method_parameters

import 'package:up_todo_app/domain/repository/repository.dart';

class ClearLocalDatabaseUseCase {
  Repository repository;
  ClearLocalDatabaseUseCase({required this.repository});

  Future<String> deleteLocalDatabase( ) async {
   return await repository.deleteLocalDatabase();
  }
}
