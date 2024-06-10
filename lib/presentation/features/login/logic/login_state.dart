import 'package:equatable/equatable.dart';
import '../../../../domain/models/login_model.dart';

abstract class LoginState {
  const LoginState();
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState with EquatableMixin {
  const LoginStateLoading();
  
  @override
  List<Object?> get props => [];
}

class LoginStateSuccess extends LoginState with EquatableMixin {
  final LoginModel loginResponse;
  const LoginStateSuccess(this.loginResponse);

 
  
  @override
  List<Object?> get props => [loginResponse];
}

class LoginStateError extends LoginState with EquatableMixin {
  final String error;
  const LoginStateError(this.error);
  
  @override
  // TODO: implement props
  List<Object?> get props =>[error];

}
