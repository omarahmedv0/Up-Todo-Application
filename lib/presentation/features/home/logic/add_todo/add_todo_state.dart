import 'package:equatable/equatable.dart';
import '../../../../../domain/models/get_todos_model.dart';

abstract class AddTodoState {
  const AddTodoState();
}

class AddTodoStateInitial extends AddTodoState {}

class AddTodoStateLoading extends AddTodoState with EquatableMixin {
  const AddTodoStateLoading();

  @override
  List<Object?> get props => [];
}

class AddTodoStateSuccess extends AddTodoState with EquatableMixin {
  final TodoModel data;
  const AddTodoStateSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AddTodoStateError extends AddTodoState with EquatableMixin {
  final String error;
  const AddTodoStateError(this.error);

  @override
  List<Object?> get props => [error];
}
