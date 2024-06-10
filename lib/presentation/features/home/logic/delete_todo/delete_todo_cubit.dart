
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/extensions.dart';
import '../../../../../domain/use_case/delete_todo_use_case.dart';
import 'delete_todo_state.dart';



class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  DeleteTodoCubit(this._deleteTodoUseCase)
      : super(const DeleteTodoStateInitial());
  final DeleteTodoUseCase _deleteTodoUseCase;

  Future<void> deleteTodo(int todoID) async {
    emit(const DeleteTodoStateLoading());
    final result = await _deleteTodoUseCase.execute(todoID);
    result.fold(
      (error) {
        emit(DeleteTodoStateError( error.message.orEmpty()));
      },
      (data) {

        emit(DeleteTodoStateSuccess(data));
      },
    );
  }
}
