import 'package:equatable/equatable.dart';
import '../../../../../domain/models/get_todos_model.dart';

abstract class UpdateTodoState{
  const UpdateTodoState();
}

class UpdateTodoInitial extends UpdateTodoState{
  const UpdateTodoInitial();
}

class UpdateTodoLoading extends UpdateTodoState with EquatableMixin{
const UpdateTodoLoading();
  @override
  List<Object?> get props => [];
 }

class UpdateTodoSuccess extends UpdateTodoState with EquatableMixin{
  final TodoModel data;
  const UpdateTodoSuccess(this.data);
  @override
  List<Object?> get props => [data];
 }

class UpdateTodoError extends UpdateTodoState with EquatableMixin{
  final String error;
  const UpdateTodoError(this.error);
  @override
  List<Object?> get props => [error];
 }