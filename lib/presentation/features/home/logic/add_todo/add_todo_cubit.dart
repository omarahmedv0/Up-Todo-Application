import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../app/extensions.dart';
import '../../../../../data/requests/requests.dart';
import '../../../../../domain/use_case/add_todo_use_case.dart';
import 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this._addTodoUseCase) : super(AddTodoStateInitial());
  final AddTodoUseCase _addTodoUseCase;
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> addTodo(AddTodoRequestBody addTodoRequestBody) async {
    emit(const AddTodoStateLoading());
    final result = await _addTodoUseCase.execute(addTodoRequestBody);
    result.fold(
      (error) {
        emit(AddTodoStateError(error.message.orEmpty()));
      },
      (data) {
        emit(AddTodoStateSuccess(data));
      },
    );
  }
}
