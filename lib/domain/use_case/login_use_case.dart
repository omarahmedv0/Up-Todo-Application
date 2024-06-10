// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/login_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginRequestBody, LoginModel> {
  Repository repository;
  LoginUseCase({required this.repository});

  @override
  Future<Either<ApiErrorModel, LoginModel>> execute(
      LoginRequestBody loginRequestBody) async {
    return await repository.login(loginRequestBody);
  }
}
