import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_prefs.dart';
import '../../../../data/requests/requests.dart';
import '../../../../domain/use_case/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase, this.appPreferences)
      : super(LoginStateInitial());
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AppPreferences appPreferences;

  Future<void> login(LoginRequestBody loginRequestBody) async {
    emit(const LoginStateLoading());
    var response = await loginUseCase.execute(loginRequestBody);
    response.fold(
      (failed) {
        emit(LoginStateError(failed.message ?? "Unknown error"));
      },
      (loginResponse) {
        appPreferences.saveUserId(loginResponse.id);
        appPreferences.setLoggedIn(true);
        emit(LoginStateSuccess(loginResponse));
      },
    );
  }
}
