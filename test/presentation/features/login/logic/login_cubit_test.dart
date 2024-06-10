import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:up_todo_app/app/app_prefs.dart';
import 'package:up_todo_app/data/networking/api_error_model.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/domain/models/login_model.dart';
import 'package:up_todo_app/domain/use_case/login_use_case.dart';
import 'package:up_todo_app/presentation/features/login/logic/login_cubit.dart';
import 'package:up_todo_app/presentation/features/login/logic/login_state.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([
  LoginUseCase,
  AppPreferences,
])
void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase loginUseCase;
  late AppPreferences appPreferences;
  setUp(() {
    appPreferences = MockAppPreferences();
    loginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(loginUseCase, appPreferences);
  });

  test(
    'LoginCubit should emit LoginLoading then LoginSuccess with LoginModel  when calling login method',
    () {
      //arrange
      final loginModel = LoginModel(
        id: 1,
        token: 'token',
        username: 'username',
        firstName: 'firstName',
        lastName: 'lastName',
        email: 'email',
        image: 'image',
        gender: 'gender',
        refreshToken: 'refreshToken',
      );
      final expectedStates = [
        const LoginStateLoading(),
        LoginStateSuccess(loginModel),
      ];
      LoginRequestBody loginRequestBody =
          const LoginRequestBody(username: 'username', password: 'password');

      when(loginUseCase.execute(loginRequestBody)).thenAnswer(
        (_) => Future.value(
          Right(loginModel),
        ),
      );

      //assert

      expectLater(loginCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      loginCubit.login(
        const LoginRequestBody(
          username: 'username',
          password: 'password',
        ),
      );
    },
  );

  test(
    '''LoginCubit should emit loginLoading then LoginErrorState
   when calling login method if usecase or repository throw an ApiErrorModel''',
    () {
      //arrange
      const errorMessage = "error";
      final expectedStates = [
        const LoginStateLoading(),
        const LoginStateError(errorMessage),
      ];
      LoginRequestBody loginRequestBody =
          const LoginRequestBody(username: 'username', password: 'password');

      when(loginUseCase.execute(loginRequestBody)).thenAnswer(
        (_) => Future.value(
          Left(ApiErrorModel(message: errorMessage)),
        ),
      );

      //assert

      expectLater(loginCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      loginCubit.login(
        const LoginRequestBody(
          username: 'username',
          password: 'password',
        ),
      );
    },
  );
}
