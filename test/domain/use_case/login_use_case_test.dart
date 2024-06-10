import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/data/networking/api_error_handler.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/login_model.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/add_todo_use_case.dart';
import 'package:up_todo_app/domain/use_case/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late Repository repository;
  late LoginUseCase loginUseCase;

  setUp(() {
    repository = MockRepository();
    loginUseCase = LoginUseCase(repository: repository);
  });
  test(
    "LoginUseCase should return LoginModel when called without error",
    () async {
      //arrange
      LoginRequestBody loginRequestBody = const LoginRequestBody(
        username: 'username',
        password: 'password',
      );
      LoginModel expectValue = LoginModel(
        token: 'token',
        username: 'username',
        id: 1,
        email:  'email',
        firstName: 'firstName',
        lastName: 'lastName',
        gender: 'gender',
        image: 'image',
        refreshToken: "refreshToken",
      );
      late LoginModel actualValue;
      when(repository.login(loginRequestBody)).thenAnswer((_) async {
        return Right(expectValue);
      });

      //act
      final result = await loginUseCase.execute(loginRequestBody);
      result.fold(
        (apiError) {},
        (login) {
          actualValue = login;
        },
      );
      //assert
      expect(actualValue, expectValue);
    },
  );

  test(
    "LoginUseCase should return apiErrorModel if there is an error",
    () async {
      //arrange
       LoginRequestBody loginRequestBody = const LoginRequestBody(
        username: 'username',
        password: 'password',
      );
      final expectedValue = DataSource.DEFAULT.getFailure();

      late ApiErrorModel actualValue;
      when(repository.login(loginRequestBody)).thenAnswer(
        (_) async => Left(expectedValue),
      );

      //act
      final result = await loginUseCase.execute(loginRequestBody);
      result.fold(
        (apiError) {
          actualValue = apiError;
        },
        (login) {},
      );
      //assert
      expect(actualValue, expectedValue);
    },
  );
}
