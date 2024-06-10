import 'package:equatable/equatable.dart';
import '../../../../../domain/models/get_todos_model.dart';

abstract class DeleteTodoState{

  const DeleteTodoState();
}

class DeleteTodoStateInitial extends DeleteTodoState{
   const DeleteTodoStateInitial();
}

class DeleteTodoStateLoading extends DeleteTodoState with EquatableMixin  {

  const DeleteTodoStateLoading();
  @override
  List<Object?> get props => [];

}

class DeleteTodoStateSuccess<T> extends DeleteTodoState with EquatableMixin  {

  final TodoModel data;
  const DeleteTodoStateSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class DeleteTodoStateError extends DeleteTodoState with EquatableMixin  { 

  final String error;
  const DeleteTodoStateError(this.error);

  @override
  List<Object?> get props => [error];
}